//
//  Filter.swift
//  RegexHelper
//
//  Created by huafeng chen on 2017/2/17.
//  Copyright © 2017年 huafeng chen. All rights reserved.
//

import UIKit

typealias Filter = (CIImage) -> CIImage

func blur(radius: Double) -> Filter {
    return { image in
        let parameters: [String: Any] = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey : image,
            ]
        guard let filter = CIFilter (name: "CIGaussianBlur",
                                     withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        return outputImage
    }
}

func generate(color: UIColor) -> Filter {
    return { _ in
        let parameters = [
            kCIInputColorKey: CIColor(cgColor: color.cgColor)
        ]
        guard let filter = CIFilter(name: "CIConstantColorGenerator",
                                    withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        return outputImage
    }
}

func compositeSourceOver(overlay: CIImage) -> Filter {
    return { image in
        let parameters = [
            kCIInputBackgroundImageKey: image,
            kCIInputImageKey          : overlay,
            ]
        guard let filter = CIFilter(name: "CISourceOverCompositing",
                                    withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        return outputImage.cropping(to: image.extent)
    }
}

func overlay(color: UIColor) -> Filter {
    return { image in
        let overlay = generate(color: color)(image).cropping(to: image.extent)
        return compositeSourceOver(overlay: overlay)(image)
    }
}

func compose(filter filter1: @escaping Filter, with filter2 : @escaping Filter) -> Filter {
    return { image in filter2(filter1(image)) }
}

//infix operator >>>
//func >>>(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {
//    return { image in filter2(filter1(image)) }
//}

infix operator >>>
func >>><A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { x in g(f(x)) }
}

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { x in { y in f(x, y) } }
}
