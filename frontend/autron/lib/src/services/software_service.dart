/// A service class that handles software.
class SoftwareService {
  /// Gets a list of software.
  ///
  /// This method is a placeholder for a future API call.
  /// TODO: Implement software model
  /// TODO: Implement software API
  Future<List<Map<String, dynamic>>> getAllSoftware() async {
    return [
      {
        "name": "Microsoft Office",
        "status": "Accepted",
        "info":
            "Microsoft Office is a suite of productivity software, including Word, Excel, and PowerPoint, used for document creation, data analysis, and presentations.",
        "departments": ["All Departments", "Finance", "HR", "Project"]
      },
      {
        "name": "Slack",
        "status": "Not Requested",
        "info":
            "Slack is a messaging platform designed for team communication and collaboration across departments.",
        "departments": ["All Departments", "Digital", "Engineering", "Sales"]
      },
      {
        "name": "Adobe Photoshop",
        "status": "Pending",
        "info":
            "Adobe Photoshop is a popular graphics editing software used for photo editing and digital artwork.",
        "departments": ["All Departments", "MarCom", "Digital"]
      },
      {
        "name": "Figma",
        "status": "Accepted",
        "info":
            "Figma is a web-based vector graphics editor and prototyping tool used for designing user interfaces and collaboration.",
        "departments": ["All Departments", "Digital", "MarCom"]
      },
      {
        "name": "Asana",
        "status": "Declined",
        "info":
            "Asana is a project management tool that helps teams organize, track, and manage their work.",
        "departments": ["All Departments", "Project", "PM"]
      },
      {
        "name": "Jira",
        "status": "Pending",
        "info":
            "Jira is a project management tool commonly used for agile development and bug tracking.",
        "departments": ["All Departments", "Engineering", "PM", "Project"]
      },
      {
        "name": "Docker",
        "status": "Not Requested",
        "info":
            "Docker is a platform that allows developers to automate the deployment of applications inside containers.",
        "departments": [
          "All Departments",
          "Engineering",
          "Operations (Factory)",
          "Operations (Warehouse)"
        ]
      },
      {
        "name": "Zoom",
        "status": "Not Requested",
        "info":
            "Zoom is a video conferencing tool used for virtual meetings, webinars, and online collaboration.",
        "departments": ["All Departments", "HR", "Sales", "PM"]
      },
      {
        "name": "Google Workspace",
        "status": "Accepted",
        "info":
            "Google Workspace is a collection of cloud computing tools including Gmail, Google Docs, Sheets, and Drive for collaboration and productivity.",
        "departments": ["All Departments", "Finance", "Sales", "HR"]
      },
      {
        "name": "Salesforce",
        "status": "Pending",
        "info":
            "Salesforce is a customer relationship management (CRM) platform used to manage sales, customer support, and marketing efforts.",
        "departments": ["All Departments", "Sales", "S&AM"]
      },
      {
        "name": "GitHub",
        "status": "Not Requested",
        "info":
            "GitHub is a platform for version control and collaboration, allowing multiple developers to work on projects simultaneously.",
        "departments": ["All Departments", "Engineering"]
      },
      {
        "name": "SAP",
        "status": "Not Requested",
        "info":
            "SAP is an enterprise resource planning (ERP) software used to manage business operations and customer relations.",
        "departments": [
          "All Departments",
          "Finance",
          "Operations (Factory)",
          "HR"
        ]
      },
      {
        "name": "Adobe Acrobat",
        "status": "Declined",
        "info":
            "Adobe Acrobat is a software used to create, edit, and manage PDF documents.",
        "departments": ["All Departments", "Finance", "HR", "Project"]
      },
      {
        "name": "Microsoft Azure",
        "status": "Accepted",
        "info":
            "Microsoft Azure is a cloud computing service used for building, testing, deploying, and managing applications through Microsoft-managed data centers.",
        "departments": [
          "All Departments",
          "Operations (Warehouse)",
          "Operations (Planning)"
        ]
      },
      {
        "name": "Power BI",
        "status": "Not Requested",
        "info":
            "Power BI is a business analytics tool by Microsoft that provides interactive visualizations and business intelligence capabilities.",
        "departments": ["All Departments", "Finance", "Operations (Planning)"]
      },
      {
        "name": "QuickBooks",
        "status": "Not Requested",
        "info":
            "QuickBooks is accounting software designed for small businesses to manage their financial operations.",
        "departments": ["All Departments", "Finance", "HR"]
      }
    ];
  }

  /// Gets software by status.
  ///
  /// Returns a list of software with the specified statuses by calling [getAllSoftware] and filtering the results.
  Future<List<Map<String, dynamic>>> getSoftwareByStatus(
      List<String> statuses) async {
    final allSoftware = await getAllSoftware();
    return allSoftware
        .where((software) => statuses.contains(software['status']))
        .toList();
  }

  /// Gets the count of accepted software.
  Future<int> getAcceptedSoftwareCount() async {
    final software = await getAllSoftware();
    return software.where((s) => s['status'] == 'Accepted').length;
  }

  /// Gets the count of pending software.
  Future<int> getPendingSoftwareCount() async {
    final software = await getAllSoftware();
    return software.where((s) => s['status'] == 'Pending').length;
  }
}
