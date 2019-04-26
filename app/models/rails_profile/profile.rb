module RailsProfile::Profile
  extend ActiveSupport::Concern
  included do
    has_taxons :area
  
    attribute :type, :string
    attribute :real_name, :string
    attribute :nick_name, :string
    attribute :birthday_type, :string
    attribute :birthday, :date
    attribute :gender, :string
    attribute :note, :string
    attribute :major, :string  # 主修科目
    attribute :degree, :string  # 学位
    attribute :address, :string
  
    belongs_to :user, optional: true
    belongs_to :area, optional: true
    has_one_attached :resume
    has_one_attached :avatar
  
  
    enum birthday_type: {
      solar: 'solar',
      lunar: 'lunar'
    }
    enum gender: {
      male: 'male',
      female: 'female'
    }
  end
  
  def age
    return 0 unless self.birthday
    r_hash = TimeHelper.exact_distance_time(self.birthday, Date.today)
    r_hash[:year]
  end

  def age_str
    return "未知" unless self.birthday
    r_hash = TimeHelper.exact_distance_time(self.birthday, Date.today)
    "#{r_hash[:year]}岁#{r_hash[:month]}月"
  end

  def avatar_url
    avatar.service_url if avatar.attachment.present?
  end


end
