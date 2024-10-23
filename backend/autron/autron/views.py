from django.core.mail import send_mail
from django.http import JsonResponse
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from rest_framework import permissions, status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Department, Software
from .serializers import DepartmentSerializer, SoftwareSerializer

# https://www.django-rest-framework.org/api-guide/views/


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


@api_view(["POST"])
def request_access_view(request):
    if request.method == "POST":
        # Get the form data from the POST request
        user_email = request.data.get("email")
        receiving_email = request.data.get("receiving_email")
        message = request.data.get("message")
        software = request.data.get("software")
        subject = request.data.get("subject", "Access Request")

        email_message = f"""
        Request Access

        User {user_email} is requesting access to software {software}.

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
