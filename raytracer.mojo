# Based on https://raytracing.github.io
import math

@value
struct Vec3:
    var x : Float64
    var y : Float64
    var z : Float64

    fn __add__(self : Self, rhs : Self) -> Self:
        return Vec3(self.x + rhs.x, self.y + rhs.y, self.z + rhs.z)

    fn __iadd__(inout self : Self, rhs : Self):
        self.x += rhs.x
        self.y += rhs.y
        self.z += rhs.z

    fn __sub__(self : Self, rhs : Self) -> Self:
        return Vec3(self.x - rhs.x, self.y - rhs.y, self.z - rhs.z)

    fn __isub__(inout self : Self, rhs : Self):
        self.x -= rhs.x
        self.y -= rhs.y
        self.z -= rhs.z

    fn __rmul__(self : Self, lhs : Float64) -> Self:
        return Vec3(self.x * lhs, self.y * lhs, self.z * lhs)

    fn __mul__(self : Self, lhs : Float64) -> Self:
        return Vec3(self.x * lhs, self.y * lhs, self.z * lhs)

    fn __imul__(inout self : Self, rhs : Float64):
        self.x *= rhs
        self.y *= rhs
        self.z *= rhs
    
    fn __rdiv__(self : Self, lhs : Float64) -> Self:
        return Vec3(self.x / lhs, self.y / lhs, self.z / lhs)

    fn __div__(self : Self, lhs : Float64) -> Self:
        return Vec3(self.x / lhs, self.y / lhs, self.z / lhs)

    fn __idiv__(inout self : Self, rhs : Float64):
        self.x /= rhs
        self.y /= rhs
        self.z /= rhs

    fn length(self : Self) -> Float64:
        return math.sqrt(self.length_squared())

    fn length_squared(self : Self) -> Float64:
        return (self.x*self.x) + (self.y*self.y) + (self.z*self.z)

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
                print("\rScanlines remaining: ", image_height-j)
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
        print("\rDone                                       ")

    except:
        print("Could not write file")