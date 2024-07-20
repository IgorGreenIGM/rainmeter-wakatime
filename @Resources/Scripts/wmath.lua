-- Wmath table to hold all math-related functions
Wmath = {}

-- Function to solve the system of linear equations:
-- ax + by = c
-- dx + ey = f
function Wmath.solvexy(a, b, c, d, e, f)
    local j = (c - a / d * f) / (b - a * e / d);
    local i = (c - (b * j)) / a;

    return i, j
end

-- Bezier curve basis functions for cubic Bezier curves
function Wmath.b0(t) return (1-t)*(1-t)*(1-t) end
function Wmath.b1(t) return t*(1-t)*(1-t)*3 end
function Wmath.b2(t) return (1-t)*t*t*3 end
function Wmath.b3(t) return t*t*t end

-- Perform Bezier interpolation and solve for control points
function Wmath.BezierInterpolation(x0, y0, x1, y1, x2, y2, x3, y3)
    local c1 = math.sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0))
    local c2 = math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
    local c3 = math.sqrt((x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2))

    -- normalized parameter t values
    local t1 = c1 / (c1 + c2 + c3)
    local t2 = (c1 + c2) / (c1 + c2 + c3)

    local xp1, xp2 = Wmath.solvexy(Wmath.b1(t1), Wmath.b2(t1), x1 - (x0 * Wmath.b0(t1)) - (x3 * Wmath.b3(t1)), Wmath.b1(t2), Wmath.b2(t2), x2 - (x0 * Wmath.b0(t2)) - (x3 * Wmath.b3(t2)))
    local yp1, yp2 = Wmath.solvexy(Wmath.b1(t1), Wmath.b2(t1), y1 - (y0 * Wmath.b0(t1)) - (y3 * Wmath.b3(t1)), Wmath.b1(t2), Wmath.b2(t2), y2 - (y0 * Wmath.b0(t2)) - (y3 * Wmath.b3(t2)))

    return xp1, yp1, xp2, yp2, t1, t2
end

-- calculate the first derivative of a cubic Bezier curve at a given t
function Wmath.CubicBezierFirstDerivate(x0, y0, x1, y1, x2, y2, x3, y3, t)
    local xder = 3*(1-t)*(1-t)*(x1-x0) + 6*(1-t)*t*(x2-x1) + 3*t*t*(x3-x2)
    local yder = 3*(1-t)*(1-t)*(y1-y0) + 6*(1-t)*t*(y2-y1) + 3*t*t*(y3-y2)

    return xder, yder
end

-- calculate the second derivative of a cubic Bezier curve at a given t
function Wmath.CubicBezierSecondDerivate(x0, y0, x1, y1, x2, y2, x3, y3, t)
    local xdder = 6*(1-t)*(x2 - 2*x1 + x0) + 6*t*(x3 - 2*x2 + x1)
    local ydder = 6*(1-t)*(y2 - 2*y1 + y0) + 6*t*(y3 - 2*y2 + x1)

    return xdder, ydder
end

-- calculate the cross product of two vectors
function Wmath.CrossProduct(x1, y1, x2, y2)
    return x1*y2 - y1*x2
end

-- calculate the curvature of a cubic Bezier curve at a given t
function Wmath.CubicBezierCurvature(x0, y0, x1, y1, x2, y2, x3, y3, t)
    local xfder, yfder = Wmath.CubicBezierFirstDerivate(x0, y0, x1, y1, x2, y2, x3, y3, t)
    local xsder, ysder = Wmath.CubicBezierSecondDerivate(x0, y0, x1, y1, x2, y2, x3, y3, t)

    local tmp = math.sqrt(xfder*xfder + ysder*ysder)
    return math.abs(Wmath.CrossProduct(xfder, yfder, xsder, ysder)) / (tmp*tmp*tmp)
end

return Wmath