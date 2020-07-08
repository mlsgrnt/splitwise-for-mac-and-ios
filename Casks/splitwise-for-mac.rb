cask 'splitwise-for-mac' do
  version '1.0'
  sha256 'fa630132a1c278ca1c37b7f48b659690838461908c4e633711d970780b2b1f26'

  name "Splitwise for Mac"
  url 'https://github.com/mlsgrnt/splitwise-for-mac/releases/download/1.0/Splitwise.app.zip'
  homepage 'https://github.com/mlsgrnt/splitwise-for-mac'
  appcast 'https://github.com/mlsgrnt/splitwise-for-mac/releases.atom'

  app 'Splitwise.app'
end
