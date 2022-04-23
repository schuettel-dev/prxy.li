class Link < ApplicationRecord
  SOMEHOW_NEVER = DateTime.new(9999).at_end_of_year.at_beginning_of_day

  attr_accessor :never_expire

  before_validation :initialize_token
  before_validation :initialize_expires_at
  before_validation :sanitize_target

  validates :token, :target, :expires_at, presence: true
  validates :token, uniqueness: true
  validates :redirect_count, numericality: { greater_than_or_equal_to: 0 }
  validate :target_is_a_valid_url

  scope :anti_chronologically, -> { order(created_at: :desc) }

  after_update_commit :update_link

  def decorate
    @decorate ||= LinkDecorator.new(self)
  end

  def visited!
    update!(redirect_count: redirect_count.next)
  end

  def expires_never?
    self.expires_at == SOMEHOW_NEVER
  end

  def target_with_https
    "https://#{target}"
  end

  private

  def initialize_token
    self.token ||= (0...6).map { [*('a'..'z'), *('A'..'Z')].flatten.to_a[rand(52)] }.join
  end

  def initialize_expires_at
    self.expires_at ||= never_expire&.to_i.positive? ? SOMEHOW_NEVER : 1.week.from_now
  end

  def sanitize_target
    self.target = target.gsub(/https?:\/\//, '')
  end

  def target_is_a_valid_url
    return if errors.any?

    url = URI.parse(target_with_https)
    return true if (url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)) && url.authority.present?
    errors.add(:target, 'is not a valid URL')
  end

  def update_link
    broadcast_replace_to :links, partial: 'links/link', locals: { link: self }
  end
end
