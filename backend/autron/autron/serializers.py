from rest_framework import serializers

from .models import *

# https://www.django-rest-framework.org/api-guide/serializers/
# Serializer example

class DepartmentSerializer(serializers.Serializer):
    name = serializers.CharField(max_length=100)

    


#     def create(self, validated_data):
#         return Comment(**validated_data)

#     def update(self, instance, validated_data):
#         instance.name = validated_data.get('name', instance.name)
#         return instance
# #     def
