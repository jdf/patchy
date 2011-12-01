package patchy.readers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import patchy.Patch;
import patchy.PatchGroup;
import patchy.Patchy;
import processing.core.PVector;

public class BPTReader {
	public static PatchGroup read(final InputStream inputStream)
			throws IOException {
		int line = 1;
		final BufferedReader in = new BufferedReader(new InputStreamReader(
				inputStream));
		try {
			final int patchCount = Integer.parseInt(in.readLine());
			line++;
			final PatchGroup result = new PatchGroup();
			for (int i = 0; i < patchCount; i++) {
				final String dimLine = in.readLine();
				if (dimLine == null) {
					throw new RuntimeException("Unexpected EOF");
				}
				final String[] dimensions = dimLine.split("\\s+");
				if (dimensions.length != 2) {
					throw new RuntimeException(
							"Expected patch dimensions at line " + line);
				}
				if (!(dimensions[0].equals("3") && dimensions[1].equals("3"))) {
					throw new RuntimeException(
							"I can only parse bicubic patches, not "
									+ dimensions[0] + "," + dimensions[1]);
				}
				final PVector[][] cp = new PVector[4][4];
				for (int x = 0; x < 4; x++) {
					for (int y = 0; y < 4; y++) {
						final String coordline = in.readLine();
						if (coordline == null) {
							throw new RuntimeException("Unexpected EOF");
						}
						final String[] coords = coordline.split("\\s+");
						cp[x][y] = new PVector(Float.parseFloat(coords[0]),
								Float.parseFloat(coords[1]),
								Float.parseFloat(coords[2]));
					}
				}
				result.add(Patch.create(Patchy.BEZIER, cp));
			}
			return result;
		} catch (final NumberFormatException e) {
			throw new RuntimeException(e + " on line " + line);
		} finally {
			in.close();
		}
	}
}
