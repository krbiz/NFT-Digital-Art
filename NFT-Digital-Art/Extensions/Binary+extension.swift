import UIKit

extension BinaryFloatingPoint {
    
    /// iPhone 11 Pro
    var deviceScreenSize: CGSize {
        CGSize(width: 375, height: 812)
    }
    
    var sizeW: CGFloat {
        CGFloat(self) * UIScreen.main.bounds.width / deviceScreenSize.width
    }
    
    var sizeH: CGFloat {
        CGFloat(self) * UIScreen.main.bounds.height / deviceScreenSize.height
    }
    
}

extension BinaryInteger {
    
    var sizeW: CGFloat {
        CGFloat(self).sizeW
    }
    
    var sizeH: CGFloat {
        CGFloat(self).sizeH
    }
    
}
