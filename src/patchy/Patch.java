/*
 The Patchy Processing library, which provides an easy-to-use
 bicubic patch object for 3D graphics.

 Copyright 2008 Jonathan Feinberg

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */
package patchy;

import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PImage;
import processing.core.PVector;

/**
 * Provides an easy-to-use bicubic patch for Processing.
 * 
 * You construct it with a 4x4 collection of control points, then
 * simply call its <code>draw()</code> method as needed.
 * 
 * The control points can be given as a 4x4 array of PVectors, 
 * 3 4x4 arrays of floats (interprested as the x, y, and z coordinates
 * respectively), or 3 4x4 arrays of doubles (interpreted like the
 * floats). All internal operations are done in double-precision,
 * which is then rounded down for drawing in PApplet.
 * 
 * A Patch has a BoundingVolume, which is useful for scaling and 
 * positioning when drawing.
 * 
 * This class is not thread-safe. In particular, if you modify a Patch's
 * control points while another thread is calling <code>draw()</code> on the
 * same instance, results are undefined.
 * 
 * @author jdf
 *
 */
public class Patch implements Patchy
{
	private static final int DEFAULT_GRID_STEPS = 20;

	// What kind of patch?
	private double[][] basis;

	// The control points decomposed into x, y, and z coords
	private final double[][] cpX;
	private final double[][] cpY;
	private final double[][] cpZ;

	private boolean dirty = true;
	private BoundingVolume bounds = null;
	private int gridSteps;

	private VertexWithNormal[][] rasterizedPoints;

	public static Patch create(final double[][] basis, final PVector[][] controlPoints)
	{
		return create(basis, controlPoints, DEFAULT_GRID_STEPS);
	}

	public static Patch create(final double[][] basis, final PVector[][] controlPoints,
			final int gridSteps)
	{
		if (controlPoints.length != 4 || controlPoints[0].length != 4)
			throw new IllegalArgumentException("controlPoints must be a 4x4 matrix");

		final double[][] cpX = new double[4][4];
		final double[][] cpY = new double[4][4];
		final double[][] cpZ = new double[4][4];

		for (int i = 0; i < 4; i++)
			for (int j = 0; j < 4; j++)
			{
				cpX[i][j] = controlPoints[i][j].x;
				cpY[i][j] = controlPoints[i][j].y;
				cpZ[i][j] = controlPoints[i][j].z;
			}
		return new Patch(basis, gridSteps, cpX, cpY, cpZ, false);
	}

	public static Patch create(final double[][] basis, final float[][] cpX,
			final float[][] cpY, final float[][] cpZ)
	{
		return create(basis, cpX, cpY, cpZ, DEFAULT_GRID_STEPS);
	}

	public static Patch create(final double[][] basis, final float[][] cpX,
			final float[][] cpY, final float[][] cpZ, final int gridSteps)
	{
		final double[][] dcpX = new double[4][4];
		final double[][] dcpY = new double[4][4];
		final double[][] dcpZ = new double[4][4];

		for (int i = 0; i < 4; i++)
			for (int j = 0; j < 4; j++)
			{
				dcpX[i][j] = cpX[i][j];
				dcpY[i][j] = cpY[i][j];
				dcpZ[i][j] = cpZ[i][j];
			}
		return new Patch(basis, gridSteps, dcpX, dcpY, dcpZ, false);
	}

	public static Patch create(final double[][] basis, final double[][] cpX,
			final double[][] cpY, final double[][] cpZ)
	{
		return create(basis, cpX, cpY, cpZ, DEFAULT_GRID_STEPS);
	}

	public static Patch create(final double[][] basis, final double[][] cpX,
			final double[][] cpY, final double[][] cpZ, final int gridSteps)
	{
		return new Patch(basis, gridSteps, cpX, cpY, cpZ, true);
	}

	private Patch(final double[][] basis, final int gridSteps, final double[][] cpX,
			final double[][] cpY, final double[][] cpZ, final boolean clone)
	{
		if (basis.length != 4 || basis[0].length != 4)
			throw new IllegalArgumentException("basis must be a 4x4 matrix");
		if (cpX.length != 4 || cpX[0].length != 4)
			throw new IllegalArgumentException("cpX must be a 4x4 matrix");
		if (cpY.length != 4 || cpY[0].length != 4)
			throw new IllegalArgumentException("cpY must be a 4x4 matrix");
		if (cpZ.length != 4 || cpZ[0].length != 4)
			throw new IllegalArgumentException("cpZ must be a 4x4 matrix");
		this.basis = basis.clone();
		this.gridSteps = gridSteps;
		this.cpX = clone ? cpX.clone() : cpX;
		this.cpY = clone ? cpY.clone() : cpY;
		this.cpZ = clone ? cpZ.clone() : cpZ;
		this.dirty = true;
	}

	public BoundingVolume getBounds()
	{
		if (dirty)
			rasterize();
		return bounds;
	}

	private void rasterize()
	{
		bounds = new BoundingVolume();

		final Bicubic cX = new Bicubic(basis, cpX);
		final Bicubic cY = new Bicubic(basis, cpY);
		final Bicubic cZ = new Bicubic(basis, cpZ);
		rasterizedPoints = new VertexWithNormal[gridSteps + 1][gridSteps + 1];
		for (int i = 0; i <= gridSteps; i++)
		{
			final double u = (double) i / gridSteps;
			for (int j = 0; j <= gridSteps; j++)
			{
				final double v = (double) j / gridSteps;
				rasterizedPoints[i][j] = Bicubic.eval(cX, cY, cZ, u, v);
				bounds = bounds.with(rasterizedPoints[i][j].vertex);
			}
		}
		dirty = false;
	}

	public void set(final int row, final int col, final double x, final double y,
			final double z)
	{
		cpX[row][col] = x;
		cpY[row][col] = y;
		cpZ[row][col] = z;
		dirty = true;
	}

	public void set(final int row, final int col, final PVector cp)
	{
		set(row, col, cp.x, cp.y, cp.z);
	}

	public void setX(final int row, final int col, final double val)
	{
		cpX[row][col] = val;
		dirty = true;
	}

	public void setY(final int row, final int col, final double val)
	{
		cpY[row][col] = val;
		dirty = true;
	}

	public void setZ(final int row, final int col, final double val)
	{
		cpZ[row][col] = val;
		dirty = true;
	}

	public void setBasis(final double[][] basis)
	{
		this.basis = basis.clone();
		dirty = true;
	}

	public void setGridSteps(final int gridSteps)
	{
		this.gridSteps = gridSteps;
		dirty = true;
	}

	public BoundingVolume scale(final double scale)
	{
		for (int x = 0; x < 4; x++)
			for (int y = 0; y < 4; y++)
			{
				cpX[x][y] *= scale;
				cpY[x][y] *= scale;
				cpZ[x][y] *= scale;
			}
		dirty = true;
		return getBounds();
	}

	public void translate(final double dx, final double dy, final double dz)
	{
		for (int x = 0; x < 4; x++)
			for (int y = 0; y < 4; y++)
			{
				cpX[x][y] += dx;
				cpY[x][y] += dy;
				cpZ[x][y] += dz;
			}
		dirty = true;
	}

	private void vertex(final PApplet p, final int row, final int col,
			final boolean textured)
	{
		final VertexWithNormal point = rasterizedPoints[row][col];
		final PVector normal = point.normal;
		final PVector vertex = point.vertex;
		if (textured || p.g.fill)
			p.normal(normal.x, normal.y, normal.z);
		if (textured)
			p.vertex(vertex.x, vertex.y, vertex.z, (float) col / gridSteps, (float) row
					/ gridSteps);
		else
			p.vertex(vertex.x, vertex.y, vertex.z);
	}

	public void draw(final PApplet p)
	{
		draw(p, null);
	}

	public void draw(final PApplet p, final PImage texture)
	{
		if (dirty)
			rasterize();
		final VertexWithNormal[][] rp = rasterizedPoints;
		p.beginShape(PConstants.TRIANGLE_STRIP);
		final boolean textured = texture != null;
		if (textured)
		{
			p.textureMode(PConstants.NORMAL);
			p.texture(texture);
		}
		for (int row = 0; row < rp.length - 1; row++)
		{
			if (row % 2 == 0)
			{
				for (int col = 0; col < rp.length; col++)
				{
					vertex(p, row, col, textured);
					vertex(p, row + 1, col, textured);
				}
			}
			else
			{
				for (int col = rp.length - 1; col > 0; col--)
				{
					vertex(p, row + 1, col, textured);
					vertex(p, row, col - 1, textured);
				}
			}
		}
		if (rp.length % 2 == 1)
			vertex(p, rp.length - 1, 0, textured);
		p.endShape();
	}

	public void drawControlPoints(final PApplet p)
	{
		for (int i = 0; i < 4; i++)
			for (int j = 0; j < 4; j++)
			{
				p.translate((float) cpX[i][j], (float) cpY[i][j], (float) cpZ[i][j]);
				p.box(.5f);
				p.translate((float) -cpX[i][j], (float) -cpY[i][j], (float) -cpZ[i][j]);
			}
	}

}
