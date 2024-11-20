from unittest.mock import patch

from autron.models import Department, Software
from autron.serializers import DepartmentSerializer, SoftwareSerializer
from django.test import TestCase
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient


class APITestCase(TestCase):

    def setUp(self):
        # Set up initial data for testing
        self.client = APIClient()
        self.department1 = Department.objects.create(name="Engineering")
        self.department2 = Department.objects.create(name="HR")
        self.department3 = Department.objects.create(name="Sales")
        self.software1 = Software.objects.create(
            name="Slack",
            department=self.department1,
            description="No description provided",
            requestmethod="GET",
        )
        self.software2 = Software.objects.create(
            name="Zoom",
            department=self.department1,
            description="No description provided",
            requestmethod="POST",
        )
        # Set up the access request URL here to avoid repetition
        self.url = reverse("request_access")

    # Check that all expected departments are returned and match the database entries.
    def test_department_list(self):
        url = reverse("department_list")
        response = self.client.get(url, follow=True)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        expected_data = DepartmentSerializer(Department.objects.all(), many=True).data
        self.assertEqual(response.json(), expected_data)

    # Verify that the response includes all software records and has correct relationships
    def test_software_list(self):
        url = reverse("software_list")
        response = self.client.get(url, follow=True)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        response_data = response.json()
        self.assertIsInstance(response_data, list)

        for software in response_data:
            self.assertIn("id", software)
            self.assertIn("name", software)
            self.assertIn("department", software)
            self.assertIn("description", software)
            self.assertIn("requestmethod", software)

            self.assertIsInstance(software["id"], int)
            self.assertIsInstance(software["name"], str)
            self.assertIsInstance(software["department"], dict)
            self.assertIsInstance(software["description"], str)
            self.assertIsInstance(software["requestmethod"], str)

            self.assertIn("id", software["department"])
            self.assertIn("name", software["department"])
            self.assertIsInstance(software["department"]["id"], int)
            self.assertIsInstance(software["department"]["name"], str)

        software_names = [s["name"] for s in response_data]
        self.assertIn("Slack", software_names)
        self.assertIn("Zoom", software_names)