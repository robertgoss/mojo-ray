from vec3 import Point3, Vec3

@value
struct Ray:
    var origin : Point3
    var direction : Vec3

    fn at(self : Self, t : Float64) -> Point3:
        return self.origin + (t * self.direction)