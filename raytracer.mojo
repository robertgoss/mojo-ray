


fn main():
    var image_width : Int16 = 256
    var image_height : Int16 = 256
    var image_scale_width : Float64 = (image_width-1).cast[DType.float64]()
    var image_scale_height : Float64 = (image_height-1).cast[DType.float64]()
    alias space = StringRef(" ")
    alias newline = StringRef("\n")
    try:
        with open("image.ppm", "w") as image:
            image.write(StringRef("P3\n"))
            image.write(str(image_width))
            image.write(space)
            image.write(str(image_height))
            image.write(StringRef("\n255\n"))
            for j in range(image_height):
                for i in range(image_width):
                    var r : Float64 = Int16(i).cast[DType.float64]() / image_scale_width
                    var g : Float64 = Int16(j).cast[DType.float64]() / image_scale_height
                    var b : Float64 = 0.0
                    
                    var ir : UInt8 = int(255.999 * r)
                    var ig : UInt8 = int(255.999 * g)
                    var ib : UInt8 = int(255.999 * b)
                    image.write(str(ir))
                    image.write(space)
                    image.write(str(ig))
                    image.write(space)
                    image.write(str(ib))
                    image.write(newline)

    except:
        print("Could not write file")