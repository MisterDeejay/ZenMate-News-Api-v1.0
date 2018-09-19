class ActiveRecord::Base
  protected
  def sanitize_for_mass_assignment_with_forbidden_attributes(*args)
    attributes = args[0]
    if attributes.respond_to?(:permitted?) && !attributes.permitted?
      if Rails.env.development? || Rails.env.test? || ENV["RAISE_FORBIDDEN_ATTRIBUTES"]
        raise ActiveModel::ForbiddenAttributesError
      end
      Rails.logger.warn "Forbidden attributes: #{self.class.name}"
    end
    sanitize_for_mass_assignment_without_forbidden_attributes(*args)
  end
  alias_method_chain :sanitize_for_mass_assignment, :forbidden_attributes
end
