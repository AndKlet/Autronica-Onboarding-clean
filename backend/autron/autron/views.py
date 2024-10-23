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
    method="POST",
    responses={200: RequestSerializer(many=True)},
    operation_description="Makes an request for a software",
)
@api_view(["POST"])
def request_software(request, software_id):
    if request.method == "POST":
        requests = Request.objects.create(software_id=software_id, request_status="Pending")
        serializer = RequestSerializer(requests)
        return JsonResponse(serializer.data, safe=False)


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


# @swagger_auto_schema(
#  method="POST",
#  request_body=SoftwareSerializer,
#  responses={201: SoftwareSerializer()},
#  operation_description="Creates a new software entry with an image",
# )
@api_view(["POST"])
@parser_classes([MultiPartParser, FormParser])
def create_software(request):
    if request.method == "POST":
        serializer = SoftwareSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=status.HTTP_201_CREATED)
        return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
