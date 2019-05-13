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

    def permitted?(feature)
      permissions.member?(feature.to_s)
    end

    def restricted?(feature)
      !permitted?(feature)
    end
  end
end
