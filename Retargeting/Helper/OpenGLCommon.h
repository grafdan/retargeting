//
//  OpenGLCommon.h
//
//  Created by Daniel Graf on 07.10.12.
//

#ifndef part2_ogles_OpenGLCommon_h
#define part2_ogles_OpenGLCommon_h

typedef struct {
	GLfloat	x;
	GLfloat y;
	GLfloat z;
} Vertex3D;

static inline Vertex3D Vertex3DMake(CGFloat inX, CGFloat inY, CGFloat inZ)
{
	Vertex3D ret;
	ret.x = inX;
	ret.y = inY;
	ret.z = inZ;
	return ret;
}
static inline void Vertex3DSet(Vertex3D *vertex, CGFloat inX, CGFloat inY, CGFloat inZ)
{
    vertex->x = inX;
    vertex->y = inY;
    vertex->z = inZ;
}

typedef struct {
    Vertex3D v1;
    Vertex3D v2;
    Vertex3D v3;
} Triangle3D;

static inline Triangle3D Triangle3DMake(Vertex3D a, Vertex3D b, Vertex3D c) {
    Triangle3D ret;
    ret.v1 = a;
    ret.v2 = b;
    ret.v3 = c;
    return ret;
}

#endif
