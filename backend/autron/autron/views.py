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

@swagger_auto_schema(
    method="GET",
    responses={200: openapi.Schema(type=openapi.TYPE_OBJECT)},
    operation_description="Successflyy logged in",
)
@api_view(["GET"])
def success(request):
    return JsonResponse({"message": "Successfully logged in!"})