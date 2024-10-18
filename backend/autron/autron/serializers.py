from rest_framework import serializers
from .models import Software, Department

class DepartmentSerializer(serializers.ModelSerializer):
    id = serializers.IntegerField()
    name = serializers.CharField(max_length=100)

class SoftwareSerializer(serializers.ModelSerializer):
    id = serializers.IntegerField()
    name = serializers.CharField(max_length=100)
    department = DepartmentSerializer()
    image = serializers.ImageField(required=False)

