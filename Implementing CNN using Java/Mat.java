/**
 * Finalized File
 * DO NOT CHANGE THIS FILE
 * Author: Zhanpeng Zeng
 */

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

public class Mat {
	public static long memory = 0; 
	public double matrix[][]; 
	public int size[]; 
	
	public Mat(int a, int b, double value) {memory += a*b; 
		size = new int[]{a, b}; 
		
		matrix = new double[a][b]; 
		for (int i = 0; i < a; i++) {
			for (int j = 0; j < b; j++)
				matrix[i][j] = value; 
		}
	}
	
	public Mat(double[] rowVector) {memory += rowVector.length; 
		size = new int[]{1, rowVector.length}; 
		this.matrix = new double[1][rowVector.length]; 
		for (int i = 0; i < rowVector.length; i++) {
			matrix[0][i] = rowVector[i]; 
		}
	}
	
	public Mat(double[][] matrix) {memory += matrix.length*matrix[0].length; 
		size = new int[]{matrix.length, matrix[0].length}; 
		this.matrix = matrix; 
	}
	
	public Mat(int a, int b) {memory += a*b; 
		size = new int[]{a, b}; 
		matrix = new double[a][b]; 
	}
	
	public static Mat randomMatrix(int a, int b, double min, double max) {memory += a*b; 
		Random rnd = new Random(); 
		
		double scale = (max - min); 
		double offset = min; 
		
		Mat result = new Mat(a, b, 0); 
		for (int i = 0; i < a; i++) {
			for (int j = 0; j < b; j++) {
				result.matrix[i][j] = rnd.nextDouble() * scale + offset; 
			}
		}
		
		return result; 
	}
	
	public Mat range(int aMin, int aMax, int bMin, int bMax) {
		if (aMin < 0 || aMax >= size[0] || bMin < 0 || bMax >= size[1]) {
			throw new IllegalArgumentException("illegal range"); 
		}
		Mat result = new Mat(aMax - aMin + 1, bMax - bMin + 1, 0); 
		for (int i = aMin; i <= aMax; i++) {
			for (int j = bMin; j <= bMax; j++) {
				result.matrix[aMin-i][bMin-j] = this.matrix[i][j]; 
			}
		}
		return result; 
	}
	
	public static double sum(Mat matrix) {
		double result = 0; 
		for (int i = 0; i < matrix.size[0]; i++) {
			for (int j = 0; j < matrix.size[1]; j++) {
				result = result + matrix.matrix[i][j]; 
			}
		}
		return result; 
	}
	
	public static Result max(Mat matrix) {
		Result output = new Result(); 
		output.max = matrix.matrix[0][0]; 
		output.idx[0] = 0; 
		output.idx[1] = 0; 
		
		for (int i = 0; i < matrix.size[0]; i++) {
			for (int j = 0; j < matrix.size[1]; j++) {
				if (output.max < matrix.matrix[i][j]) {
					output.max = matrix.matrix[i][j]; 
					output.idx[0] = i; 
					output.idx[1] = j; 
				}
			}
		}
		return output; 
	}
	
	public Mat appendRight(Mat m) {
		List<Mat> list = new ArrayList<Mat>(); 
		list.add(this); 
		list.add(m); 
		return Mat.marge(list); 
	}
	
	public static Mat marge(List<Mat> list) {
		int height = list.get(0).size[0]; 
		for (Iterator<Mat> itr = list.iterator(); itr.hasNext(); ) {
			if (itr.next().size[0] != height)
				throw new IllegalArgumentException(); 
		}
		
		int width = 0; 
		for (Iterator<Mat> itr = list.iterator(); itr.hasNext(); ) 
			width = width + itr.next().size[1]; 
		
		Mat result = new Mat(height, width, 0); 
		for (int i = 0; i < height; i++) {
			int k = 0; 
			for (Iterator<Mat> itr = list.iterator(); itr.hasNext(); ) {
				Mat temp = itr.next(); 
				for (int j = 0; j < temp.size[1]; j++) {
					result.matrix[i][k] = temp.matrix[i][j]; 
					k++; 
				}
			}
		}
		
		return result; 
	}
	
	public Mat copy() {
		Mat result = new Mat(this.size[0], this.size[1], 0); 
		for (int i = 0; i < result.size[0]; i++) {
			for (int j = 0; j < result.size[1]; j++) {
				result.matrix[i][j] = this.matrix[i][j]; 
			}
		}
		return result; 
	}
	
	public Mat eleWiseMul(Mat B) {
		if ((B.size[0] != this.size[0]) ||(B.size[1] != this.size[1])) {
			throw new IllegalArgumentException("Dimension mismatch"); 
		}
		Mat result = new Mat(this.size[0], this.size[1]); 
		for (int i = 0; i < result.size[0]; i++) {
			for (int j = 0; j < result.size[1]; j++) {
				result.matrix[i][j] = this.matrix[i][j] * B.matrix[i][j]; 
			}
		}
		return result; 
	}
	
	public Mat mul(Mat B) {
		if (this.size[1] != B.size[0]) {
			throw new IllegalArgumentException(); 
		}
		Mat result = new Mat(this.size[0], B.size[1]); 
		
		for (int i = 0; i < result.size[0]; i++) {
			for (int j = 0; j < result.size[1]; j++) {
				double accumulator = 0; 
				for (int k = 0; k < this.size[1]; k++) {
					accumulator = accumulator + this.matrix[i][k] * B.matrix[k][j]; 
				}
				result.matrix[i][j] = accumulator; 
			}
		}
		
		return result; 
	}
	
	public Mat add(Mat B) {
		if ((this.size[0] != B.size[0]) || (this.size[1] != B.size[1])) {
			throw new IllegalArgumentException(); 
		}
		Mat result = new Mat(this.size[0], this.size[1]); 
		
		for (int i = 0; i < result.size[0]; i++) {
			for (int j = 0; j < result.size[1]; j++) {
				result.matrix[i][j] = this.matrix[i][j] + B.matrix[i][j]; 
			}
		}
		return result; 
	}
	
	public Mat scale(double scale) {
		Mat result = new Mat(this.size[0], this.size[1]); 
		for (int i = 0; i < result.size[0]; i++) {
			for (int j = 0; j < result.size[1]; j++)
				result.matrix[i][j] = this.matrix[i][j] * scale; 
		}
		return result; 
	}
	
	public Mat T() {
		Mat result = new Mat(this.size[1], this.size[0]); 
		for (int i = 0; i < result.size[0]; i++) {
			for (int j = 0; j < result.size[1]; j++)
				result.matrix[i][j] = this.matrix[j][i]; 
		}
		return result; 
	}
	
	public static Mat pow(Mat input, double power) {
		Mat result = new Mat(input.size[0], input.size[1]); 
		for (int i = 0; i < result.size[0]; i++) {
			for (int j = 0; j < result.size[1]; j++) {
				result.matrix[i][j] = Math.pow(input.matrix[i][j], power); 
			}
		}
        return result;
	}
	
	public Mat row(int idx) {
		return new Mat(this.matrix[idx]); 
	}
	
	public String toString() {
		String result = "[";
		for (int i = 0; i < this.size[0]; i++) {
			for (int j = 0; j < this.size[1]; j++) {
				result = result + String.format("%.4f", this.matrix[i][j]);
				if (j != this.size[1] - 1)
					result = result + ", ";
			}
			
			if (i != this.size[0] - 1)
				result = result + "; \n"; 
		}
		result = result +"];\n";
		return result; 
	}

}

class Result {
	public double max; 
	public int idx[] = new int[2]; 
}
