class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  # Добавляем uploader, чтобы заработал carrierwave
  mount_uploader :photo, PhotoUploader

  # Scope нужен, чтобы отделить реальные фотки от болванки,
  # которую мы прописали в контроллере событий
  scope :persisted, -> { where "id IS NOT NULL" }
  validate :check_amount_files

  private

    def check_amount_files
      if self.event.photos.count >= 5
        errors.add(:base, "must not contain more than 4 files")
      end
    end
end
