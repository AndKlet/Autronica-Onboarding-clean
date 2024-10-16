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
    email = request.data.get("email")
    recipient_email = request.data.get("recipient_email")
    message = request.data.get("message")

    if not email or not recipient_email or not message:
        return Response({"error": "All fields are required."}, status=status.HTTP_400_BAD_REQUEST)

    try:
        send_mail(
            subject="Access Request",
            message=message,
            from_email=email,
            recipient_list=[recipient_email],
            fail_silently=False,
        )
        return Response({"success": "Email sent successfully."}, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
