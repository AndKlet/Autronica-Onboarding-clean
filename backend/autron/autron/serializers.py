from rest_framework import serializers
from .models import *

# https://www.django-rest-framework.org/api-guide/serializers/
# Serializer example

# class ExampleSerializer(serializers.Serializer):
#     name = serializers.CharField(max_length=100)
#     email = serializers.EmailField()
#     created = serializers.DateTimeField()
#
#     def create(self, validated_data):
#         return Comment(**validated_data)
#
#     def update(self, instance, validated_data):
#         instance.email = validated_data.get('email', instance.email)
#         instance.content = validated_data.get('content', instance.content)
#         instance.created = validated_data.get('created', instance.created)
#         return instance
#     def