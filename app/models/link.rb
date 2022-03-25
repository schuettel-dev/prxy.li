class Link < ApplicationRecord
  before_validation :initialize_token

  validates :token, :target, :expires_at, presence: true
  validates :token, uniqueness: true
  validates :redirect_count, numericality: { greater_than_or_equal_to: 0 }
  validate :target_is_a_valid_url

  scope :anti_chronologically, -> { order(created_at: :desc) }

  def decorate
    @decorate ||= LinkDecorator.new(self)
  end

  def visited!
    update!(redirect_count: redirect_count.next)
  end

  private

  def initialize_token
    self.token = SecureRandom.alphanumeric(6)
  end

  def target_is_a_valid_url
    return if errors.any?

    url = URI.parse(target)
    return true if (url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)) && url.authority.present?
    errors.add(:target, 'is not a valid URL')
  end
end
