from vec3 import Point3, dot
from ray import Ray
from hittable import HitRecord, Hittable

import math

@value
struct Sphere(Hittable):
    var center : Point3
    var radius : Float64

    fn hit(self : Self, ray : Ray, t_min : Float64, t_max : Float64, inout rec : HitRecord) -> Bool:
        var oc = self.center - ray.origin
        var a = ray.direction.length_squared()
        var h = dot(ray.direction, oc)
        var c = oc.length_squared() - self.radius*self.radius
        var discriminant = h*h - a*c
        if discriminant < 0:
            return False

        var sqrtd = math.sqrt(discriminant)

        # Find the nearest root that lies in the acceptable range.
        var root = (h - sqrtd) / a
        if root <= t_min or t_max <= root:
            root = (h + sqrtd) / a
            if root <= t_min or t_max <= root:
                return False
        # Setup the record
        rec.t = root
        rec.point = ray.at(rec.t)
        var outward_normal = (rec.point - self.center) / self.radius
        rec.set_face_normal(ray, outward_normal)
        return True

