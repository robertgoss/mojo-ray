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

    fn __neg__(self : Self) -> Self:
        return Vec3(-self.x, -self.y, -self.z)

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

    fn __truediv__(self : Self, lhs : Float64 ) -> Self:
        return Vec3(self.x / lhs, self.y / lhs, self.z / lhs)

    fn length(self : Self) -> Float64:
        return math.sqrt(self.length_squared())

    fn length_squared(self : Self) -> Float64:
        return dot(self, self)

fn dot(u : Vec3, v : Vec3) -> Float64:
    return (u.x * v.x) + (u.y * v.y) + (u.z * v.z)

fn cross(u : Vec3, v : Vec3) -> Vec3:
    return Vec3(
        u.y*v.z - u.z*v.y,
        u.z*v.x - u.x*v.z,
        u.x*v.y - u.y*v.x
    )

fn unit_vector(v : Vec3) -> Vec3:
    return v / v.length()

alias Point3 = Vec3
alias UnitVec3 = Vec3