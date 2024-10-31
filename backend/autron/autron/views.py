from django.core.mail import send_mail
from django.http import JsonResponse
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from rest_framework import permissions, status
from rest_framework.decorators import (api_view, parser_classes,
                                       permission_classes)
from rest_framework.parsers import FormParser, MultiPartParser
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Department, Request, Software
from .serializers import (DepartmentSerializer, RequestSerializer,
                          SoftwareSerializer)

from django.contrib.auth.decorators import login_required
from django.http import JsonResponse

import requests
from django.conf import settings
from django.shortcuts import redirect
from django.contrib.auth import login
from django.http import JsonResponse

import requests
from django.conf import settings
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from rest_framework.decorators import api_view


@swagger_auto_schema(
    method="GET",
    responses={200: SoftwareSerializer(many=True)},
    operation_description="Gets all software",
)
@api_view(["GET"])
def software_list(request):
    if request.method == "GET":
        software = Software.objects.all()
        serializer = SoftwareSerializer(software, many=True)
        return JsonResponse(serializer.data, safe=False)


@swagger_auto_schema(
    method="GET",
    responses={200: SoftwareSerializer(many=True)},
    operation_description="Gets all departments",
)
@api_view(["GET"])
def department_list(request):
    if request.method == "GET":
        department = Department.objects.all()
        serializer = DepartmentSerializer(department, many=True)
        return JsonResponse(serializer.data, safe=False)


@swagger_auto_schema(
    method="GET",
    responses={200: SoftwareSerializer(many=True)},
    operation_description="Gets all software for a department",
)
@api_view(["GET"])
def software_by_department(request, department_id):
    if request.method == "GET":
        software = Software.objects.filter(department=department_id)
        serializer = SoftwareSerializer(software, many=True)
        return JsonResponse(serializer.data, safe=False)


@swagger_auto_schema(
    method="GET",
    responses={200: openapi.Schema(type=openapi.TYPE_OBJECT)},
    operation_description="Successfully logged in",
)

@login_required
@api_view(["GET"])
def success(request):
    # Retrieve the access token from the session
    okta_callback(request)
    access_token = request.session.get("access_token")
    if not access_token:
        return JsonResponse({"error": "Access token not found"}, status=401)

    # Okta user info endpoint
    url = f"{settings.OKTA_ORG_URL}/oauth2/default/v1/userinfo"
    headers = {
        "Authorization": f"Bearer {access_token}",
    }

    # Make a GET request to the userinfo endpoint
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        user_info = response.json()
        return JsonResponse({"message": "Successfully logged in!", "user_info": user_info})
    else:
        return JsonResponse({"error": "Failed to fetch user info from Okta"}, status=response.status_code)

@api_view(["POST"])
def request_access_view(request):
    if request.method == "POST":
        # Get the form data from the POST request
        user_email = request.data.get("email")
        receiving_email = request.data.get("receiving_email")
        message = request.data.get("message")
        subject = request.data.get("subject", "Access Request")
        software_name = request.data.get("software_name")

        email_message = f"""
        Request Access

        User {user_email} is requesting access to software {software_name}.

        Employee reasoning:
        {message}

        Click the link to start the process:
        http://customer_request.portal.com
        """

        try:
            # Send the email using Django's email system
            send_mail(
                subject,
                email_message,
                user_email,
                [receiving_email],
                fail_silently=False,
            )

            return JsonResponse(
                {"message": "Request sent successfully."}, status=status.HTTP_200_OK
            )
        except Exception as e:
            return JsonResponse({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@swagger_auto_schema(
    method="GET",
    responses={200: RequestSerializer(many=True)},
    operation_description="Get all requests",
)
@api_view(["GET"])
def request_list(request):
    if request.method == "GET":
        request = Request.objects.all()
        serializer = RequestSerializer(request, many=True)
        return JsonResponse(serializer.data, safe=False)


@swagger_auto_schema(
    method="POST",
    responses={200: RequestSerializer(many=True)},
    operation_description="Makes an request for a software",
)
@api_view(["POST"])
def request_software(request, software_id):
    if request.method == "POST":
        requests = Request.objects.create(software_id=software_id, status="Pending")
        serializer = RequestSerializer(requests)
        return JsonResponse(serializer.data, safe=False)
    
def okta_callback(request):
    # Get the authorization code from the callback URL
    authorization_code = request.GET.get("code")
    if not authorization_code:
        return JsonResponse({"error": "Authorization code not found"}, status=401)

    # Exchange the authorization code for an access token
    token_url = f"{settings.OKTA_AUTH['ORG_URL']}/oauth2/default/v1/token"
    redirect_uri = settings.OKTA_AUTH["REDIRECT_URI"]
    client_id = settings.OKTA_AUTH["CLIENT_ID"]
    client_secret = settings.OKTA_AUTH["CLIENT_SECRET"]

    # Prepare the data for the token request
    data = {
        "grant_type": "authorization_code",
        "code": authorization_code,
        "redirect_uri": redirect_uri,
        "client_id": client_id,
        "client_secret": client_secret,
    }

    # Send a POST request to Okta to exchange the code for tokens
    response = requests.post(token_url, data=data)
    if response.status_code == 200:
        tokens = response.json()
        access_token = tokens.get("access_token")
        id_token = tokens.get("id_token")
        
        # Store the access token in the session
        request.session["access_token"] = access_token

        # Optionally, store id_token or any other information as needed
        # Redirect to success page or handle user login
        return redirect('/success')
    else:
        # Handle token request failure
        return JsonResponse({"error": "Failed to obtain access token"}, status=response.status_code)