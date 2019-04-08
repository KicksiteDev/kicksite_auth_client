require_relative '../helpers/no_svc_object'

module Auth
  # Provides helper methods to call on UserSession.user object
  class User < NoSvcObject
    def student?
      person_type.casecmp?('student')
    end

    def employee?
      person_type.casecmp?('employee')
    end

    def administrator?
      person_type.casecmp?('administrator')
    end
  end
end
