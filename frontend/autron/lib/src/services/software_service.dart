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
        'name': 'Adobe XD',
        'status': 'Accepted',
        'info':
            'Adobe XD is a vector-based user experience design tool for web apps and mobile apps, developed and published by Adobe Inc. It is available for macOS and Windows, although there are versions for iOS and Android to help preview the result of work directly on mobile devices.',
        'departments': ['UI/UX Design'],
      },
      {
        'name': 'TensorFlow',
        'status': 'Pending',
        'info':
            'TensorFlow is an open-source software library for dataflow and differentiable programming across a range of tasks. It is a symbolic math library and is also used for machine learning applications such as neural networks.',
        'departments': ['Artificial Intelligence', 'Data Science'],
      },
      {
        'name': 'PyTorch',
        'status': 'Declined',
        'info':
            'PyTorch is an open-source machine learning library based on the Torch library, used for applications such as natural language processing. It is primarily developed by Facebook\'s AI Research lab.',
        'departments': ['Artificial Intelligence', 'Data Science'],
      },
      {
        'name': 'Azure',
        'status': 'Accepted',
        'info':
            'Microsoft Azure, commonly referred to as Azure, is a cloud computing service created by Microsoft for building, testing, deploying, and managing applications and services.',
        'departments': ['Cloud Computing'],
      },
      {
        'name': 'Okta',
        'status': 'Not Requested',
        'info':
            'Okta is an identity and access management software used for securing digital environments. It provides single sign-on (SSO), multi-factor authentication (MFA), and lifecycle management for user identities.',
        'departments': ['Cyber Security'],
      },
      {
        'name': 'KnownBet64',
        'status': 'Not Requested',
        'info':
            'KnownBet64 is a cybersecurity software solution for protecting digital assets.',
        'departments': ['Cyber Security'],
      },
      {
        'name': 'miro',
        'status': 'Not Requested',
        'info':
            'Miro is an online collaborative whiteboard platform used for brainstorming and team collaboration.',
        'departments': ['Cyber Security'],
      },
      {
        'name': 'SLACK',
        'status': 'Not Requested',
        'info':
            'Slack is a messaging platform for team communication and collaboration.',
        'departments': ['Cyber Security'],
      },
      {
        'name': 'Jupyter',
        'status': 'Not Requested',
        'info':
            'Jupyter is an open-source web application used for creating and sharing documents that contain live code, equations, visualizations, and text.',
        'departments': ['Data Science'],
      },
      {
        'name': 'Pandas',
        'status': 'Not Requested',
        'info':
            'Pandas is a data analysis library in Python, used for data manipulation and analysis.',
        'departments': ['Data Science'],
      },
      {
        'name': 'Git',
        'status': 'Not Requested',
        'info':
            'Git is a distributed version control system for tracking changes in source code.',
        'departments': ['Software Engineering'],
      },
      {
        'name': 'Docker',
        'status': 'Not Requested',
        'info':
            'Docker is a platform for developing, shipping, and running applications inside lightweight containers.',
        'departments': ['Software Engineering'],
      },
      {
        'name': 'Figma',
        'status': 'Not Requested',
        'info':
            'Figma is a vector graphics editor and prototyping tool used for UI/UX design.',
        'departments': ['UI/UX Design'],
      },
      {
        'name': 'AWS',
        'status': 'Not Requested',
        'info':
            'Amazon Web Services (AWS) is a cloud computing platform offering a wide range of services for computing, storage, and networking.',
        'departments': ['Cloud Computing'],
      },
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

  /// Gets software by selected status.
  ///
  /// Returns a list of software filtered by the selected status.
  Future<List<Map<String, dynamic>>> getSoftwareBySelectedStatus(
      String status) async {
    final allSoftware = await getAllSoftware();
    return allSoftware
        .where((software) => software['status'] == status)
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
