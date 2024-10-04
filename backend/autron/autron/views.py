from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework import permissions
from rest_framework.decorators import api_view, permission_classes
from django.http import JsonResponse

from .models import *
from .serializers import *

# https://www.django-rest-framework.org/api-guide/views/
# Generic class based API view example where ObjectSerializer is the serializer class for the ModelObject model.

# @api_view(['GET', 'POST'])
# @permission_classes([permissions.IsAuthenticated])
# class API(APIView):

#     Get method to get all the objects
#     def get(self, request) -> Response:
#         software = ModelObject.objects.all()
#         serializer = ObjectSerializer(software, many=True)
#         return Response(serializer.data)

#     Post method to create a new object
#     def post(self, request) -> Response:
#         serializer = ObjectSerializer(data=request.data) 
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# Generic function based API view example

# @api_view(['GET', 'POST'])
# def software_list(request):
#     if request.method == 'GET':
#         software = Software.objects.all()
#         serializer = SoftwareSerializer(software, many=True)
#         return JsonResponse(serializer.data, safe=False)

#     elif request.method == 'POST':
#         serializer = SoftwareSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return JsonResponse(serializer.data, status=status.HTTP_201_CREATED)
#         return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
