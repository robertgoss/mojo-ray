from vec3 import Point3, Vec3, dot
from ray import Ray

struct HitRecord:
    var point : Point3
    var normal : Vec3
    var t : Float64
    var front_face : Bool

    fn set_face_normal(inout self : Self, ray : Ray, outward_normal : Vec3):
        self.front_face = dot(ray.direction, outward_normal) < 0
        if self.front_face:
            self.normal = outward_normal
        else:
            self.normal = -outward_normal

trait Hittable(Movable):
    fn hit(self : Self, ray : Ray, t_min : Float64, t_max : Float64, inout rec : HitRecord) -> Bool: 
        ...

