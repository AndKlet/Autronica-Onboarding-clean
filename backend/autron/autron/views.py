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


# Function for the endpoint that returns a list of software
@swagger_auto_schema(
    method="GET",
    responses={200: SoftwareSerializer(many=True)},
    operation_description="Gets all software",
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
    ),
)
@api_view(["GET"])
def software_list(request):
    if request.method == "GET":
        software = Software.objects.all()
        serializer = SoftwareSerializer(software, many=True)
        return JsonResponse(serializer.data, safe=False)


# Function for the endpoint that returns a list of departments
@swagger_auto_schema(
    method="GET",
    responses={200: SoftwareSerializer(many=True)},
    operation_description="Gets all departments",
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
    ),
)
@api_view(["GET"])
def department_list(request):
    if request.method == "GET":
        department = Department.objects.all()
        serializer = DepartmentSerializer(department, many=True)
        return JsonResponse(serializer.data, safe=False)


class CustomEndpointView(APIView):
    """
    Custom Endpoint Description
    """

    @swagger_auto_schema(
        operation_description="Endpoint Operation Description",
        responses={
            200: "Success",
            400: "Bad Request",
            401: "Unauthorized",
        },
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                "field1": openapi.Schema(
                    type=openapi.TYPE_STRING, description="Field 1 Description"
                ),
                "field2": openapi.Schema(
                    type=openapi.TYPE_STRING, description="Field 2 Description"
                ),
            },
            required=["field1"],
        ),
    )
    def post(self, request):
        """
        Custom POST Endpoint
        """
        return Response("Success")
