Pod::Spec.new do |s|

  s.name         = "WHC_AutoLayoutKit(Swift)"
  s.version      = "2.6.4"
  s.summary      = "Swift3.0 Service to update constraints, convenient and quick dynamic UI layout，服务于更新约束方便快捷动态UI构建的自动布局库，支持Cell高度自动，view高宽自动"

  s.homepage     = "https://github.com/netyouli/WHC_AutoLayoutKit"

  s.license      = "MIT"

  s.author             = { "吴海超(WHC)" => "712641411@qq.com" }

  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/netyouli/WHC_AutoLayoutKit.git", :tag => "2.6.4"}

  s.source_files  = "WHC_AutoLayoutKit(Swift3.0)/WHC_AutoLayoutKit/*.{swift}"

  s.requires_arc = true


end
