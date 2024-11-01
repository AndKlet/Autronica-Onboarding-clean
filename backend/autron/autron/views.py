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
    access_token = request.session.get("tokens", {}).get("access_token")
    if access_token:
        # Return a JSON response with the access token directly
        return JsonResponse({"access_token": access_token}, status=200)
    else:
        return JsonResponse({"error": "Access token not found"}, status=401)
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
    pass

