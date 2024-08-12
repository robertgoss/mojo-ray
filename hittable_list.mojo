from hittable import Hittable

struct HitableList:
    var entities : List[Arc[Hittable]]