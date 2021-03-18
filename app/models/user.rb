class User < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :bookmarks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: %i[twitter]

  has_one_attached :avatar, dependent: :destroy

  after_commit :add_default_avatar, on: %i[create update]


  def avatar_thumbnail
    if avatar.attached?
      avatar
    else
      "/default_profile.png"
    end
  end

  validates :name,  presence: true,  length: {maximum: 50 }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image.gsub!("_normal","")
      user.uid = auth.uid # assuming the user model has an image
      user.provider = auth.provider
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      nil
    end
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_profile.png'
          )
        ),
        filename: 'default_profile.png',
        content_type: 'image/png'
      )
    end
  end

end
