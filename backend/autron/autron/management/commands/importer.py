import csv

from autron.models import Department, Software
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = "Import departments and software from a csv file"

    def add_arguments(self, parser):
        parser.add_argument("path", type=str, help="Path to the csv file")

    def handle(self, *args, **options):
        path = options["path"]

        with open(path) as file:
            reader = csv.reader(file)
            # Skip the header row
            next(reader)
            for row in reader:
                department, created = Department.objects.get_or_create(name=row[1])
                Software.objects.create(
                    name=row[0],
                    department=department,  # Use the Department instance
                    # description="", # empty description for now
                    # resolver_content_type=None,
                    # resolver_object_id=None,
                )
