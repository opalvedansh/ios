class AppConstants {
  // Date format
  static const String dateFormat = 'yyyy-MM-dd';
  static const String displayDateFormat = 'dd MMM yyyy';
  static const String displayDateTimeFormat = 'dd MMM yyyy, hh:mm a';

  // Status values
  static const List<String> cleaningStatuses = [
    'completed',
    'missed',
    'pending'
  ];
  static const List<String> subscriptionStatuses = [
    'active',
    'cancelled',
    'overdue'
  ];
  static const List<String> complaintStatuses = [
    'open',
    'in_progress',
    'resolved'
  ];
  static const List<String> leaveStatuses = ['pending', 'approved', 'rejected'];

  // Vehicle types
  static const List<String> vehicleTypes = ['hatchback', 'sedan', 'suv'];

  // Complaint categories
  static const List<String> complaintCategories = [
    'missed_cleaning',
    'quality',
    'behaviour',
    'other',
  ];

  // User roles
  static const String roleCustomer = 'customer';
  static const String roleStaff = 'staff';
  static const String roleAdmin = 'admin';

  // File size limits
  static const int maxImageSizeBytes = 5 * 1024 * 1024; // 5MB

  // Pagination
  static const int defaultPageSize = 50;

  // Collections
  static const String customersCollection = 'customers';
  static const String staffCollection = 'staff';
  static const String areasCollection = 'areas';
  static const String cleaningsCollection = 'cleanings';
  static const String complaintsCollection = 'complaints';
  static const String paymentsCollection = 'payments';
  static const String leavesCollection = 'leaves';
  static const String usersCollection = 'users';
}
