package patchy;

import processing.core.PVector;

/* 

 This file started out as Ken Perlin's superb Cubic class, available here:

 http://mrl.nyu.edu/~perlin/cubic/Cubic_java.html

 I have modified it extensively, but include his attribution, with
 gratitude and respect.

 Java class to implement cubic and bicubic splines 
 by Ken Perlin @ NYU, 1998, 2004. 
 You have my permission to use freely, as long as you keep the attribution. - Ken Perlin 

 */
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
public class Bicubic
{
	public static final double[][] BEZIER = { // Bezier basis matrix
	{ -1, 3, -3, 1 }, //
			{ 3, -6, 3, 0 }, //
			{ -3, 3, 0, 0 }, //
			{ 1, 0, 0, 0 } };
	public static final double[][] BSPLINE = { // BSpline basis matrix
	{ -1. / 6, 3. / 6, -3. / 6, 1. / 6 }, //
			{ 3. / 6, -6. / 6, 3. / 6, 0. },//
			{ -3. / 6, 0., 3. / 6, 0. }, //
			{ 1. / 6, 4. / 6, 1. / 6, 0. } };
	public static final double[][] CATMULL_ROM = { // Catmull-Rom basis matrix
	{ -0.5, 1.5, -1.5, 0.5 }, //
			{ 1, -2.5, 2, -0.5 }, //
			{ -0.5, 0, 0.5, 0 }, //
			{ 0, 1, 0, 0 } };
	public static final double[][] HERMITE = { // Hermite basis matrix
	{ 2, -2, 1, 1 }, //
			{ -3, 3, -2, -1 }, //
			{ 0, 0, 1, 0 }, //
			{ 1, 0, 0, 0 } };

	final double[][] C = new double[4][4];

	public Bicubic(final double[][] basis, final double[][] controlPoints)
	{
		double[][] T = new double[4][4];

		for (int i = 0; i < 4; i++)
			// T = G MT
			for (int j = 0; j < 4; j++)
				for (int k = 0; k < 4; k++)
					T[i][j] += controlPoints[i][k] * basis[j][k];

		for (int i = 0; i < 4; i++)
			// C = M T
			for (int j = 0; j < 4; j++)
				for (int k = 0; k < 4; k++)
					C[i][j] += basis[i][k] * T[k][j];

		//		C = multiply(basis, multiply(controlPoints, basis));
	}

	private static class EvalResult
	{
		public final float value, du, dv;

		public EvalResult(final double value, final double du, final double dv)
		{
			this.value = (float) value;
			this.du = (float) du;
			this.dv = (float) dv;
		}
	}

	public static VertexWithNormal eval(final Bicubic x, final Bicubic y,
			final Bicubic z, final double u, final double v)
	{
		final EvalResult xr = x.eval(u, v);
		final EvalResult yr = y.eval(u, v);
		final EvalResult zr = z.eval(u, v);
		final PVector vertex = new PVector(xr.value, yr.value, zr.value);
		final PVector normal = new PVector(xr.du, yr.du, zr.du).cross(
				new PVector(xr.dv, yr.dv, zr.dv)).normalize(null);
		return new VertexWithNormal(vertex, normal);
	}

	public EvalResult eval(final double u, final double v)
	{
		final double usquare = u * u;
		final double[][] U = new double[][] { { usquare * u, usquare, u, 1 } };
		final double vsquare = v * v;
		final double[][] V = new double[][] { { vsquare * v }, { vsquare }, { v }, { 1 } };
		final double[][] dU = new double[][] { { 3 * usquare, 2 * u, 1, 0 } };
		final double[][] dV = new double[][] { { 3 * vsquare }, { 2 * v }, { 1 }, { 0 } };
		final double[][] cv = multiply(C, V);
		final double value = multiply0_0(U, cv);
		final double du = multiply0_0(dU, cv);
		final double dv = multiply0_0(U, multiply(C, dV));
		return new EvalResult(value, du, dv);
	}

	private static double[][] multiply(final double[][] a, final double[][] b)
	{
		final int nRows = a.length;
		final int nCols = b[0].length;
		final int nSum = a[0].length;
		double[][] outData = new double[nRows][nCols];
		for (int row = 0; row < nRows; row++)
		{
			for (int col = 0; col < nCols; col++)
			{
				double sum = 0;
				for (int i = 0; i < nSum; i++)
					sum += a[row][i] * b[i][col];
				outData[row][col] = sum;
			}
		}
		return outData;
	}

	private static double multiply0_0(final double[][] a, final double[][] b)
	{
		final int nSum = a[0].length;
		double sum = 0;
		for (int i = 0; i < nSum; i++)
			sum += a[0][i] * b[i][0];
		return sum;
	}

	public static void main(final String[] args)
	{
		final double[][] cpX = new double[][] { { 23, 41, 59, 77 }, { 23, 41, 59, 77 },
				{ 23, 41, 59, 77 }, { 23, 41, 59, 77 } };
		Bicubic cubic = new Bicubic(BSPLINE, cpX);
		System.err.println(cubic.eval(0, 0).value);
	}
}
