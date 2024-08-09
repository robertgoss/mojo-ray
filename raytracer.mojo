# Based on https://raytracing.github.io
from vec3 import Vec3
from colour import write_colour

fn main():
    alias space = StringRef(" ")
    var image_width : Int16 = 256
    var image_height : Int16 = 256
    var image_scale_width : Float64 = (image_width-1).cast[DType.float64]()
    var image_scale_height : Float64 = (image_height-1).cast[DType.float64]()
    try:
        with open("image.ppm", "w") as image:
            image.write(StringRef("P3\n"))
            image.write(str(image_width))
            image.write(space)
            image.write(str(image_height))
            image.write(StringRef("\n255\n"))
            for j in range(image_height):
                print("\rScanlines remaining: ", image_height-j)
                for i in range(image_width):
                    var colour = Vec3(
                        Int16(i).cast[DType.float64]() / image_scale_width,
                        Int16(j).cast[DType.float64]() / image_scale_height,
                        0.0
                    ) 
                    write_colour(image, colour)
                    
        print("\rDone                                       ")

    except:
        print("Could not write file")