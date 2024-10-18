from rest_framework import serializers
from .models import Software, Department

class DepartmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Department
        fields = ['id', 'name']

class SoftwareSerializer(serializers.ModelSerializer):
    department = serializers.PrimaryKeyRelatedField(queryset=Department.objects.all())
    image = serializers.ImageField(required=False)

    class Meta:
        model = Software
        fields = ['id', 'name', 'department', 'image']
