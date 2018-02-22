import java.util.Random;

public class testConv {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(3/2);
		/*
		Random rnd = new Random(); 
		double Amatrix[][] = new double[rnd.nextInt(50)+5][rnd.nextInt(50)+5]; 
		for (int i = 0; i < Amatrix.length; i++) {
			for (int j = 0; j < Amatrix[0].length; j++) {
				Amatrix[i][j] = rnd.nextDouble(); 
			}
		}
		Mat A = new Mat(Amatrix); 
		System.out.println("A=" + A);
		System.out.println("rA = " + ROT180(A));
		
		double Bmatrix[][] = new double[(rnd.nextInt(10))*2+1][(rnd.nextInt(10))*2+1]; 
		for (int i = 0; i < Bmatrix.length; i++) {
			for (int j = 0; j < Bmatrix[0].length; j++) {
				Bmatrix[i][j] = rnd.nextDouble(); 
			}
		}
		
		Mat B = new Mat(Bmatrix); 
		System.out.println("B=" + B);
		
		System.out.println("r=" + Conv.Conv2Same(A, B)); */
	}
	
	private static Mat ROT180(Mat input) {
		Mat output = new Mat(input.size[0], input.size[1], 0); 
		for (int i = 0; i < input.size[0]; i++) {
			for (int j = 0; j < input.size[1]; j++) {
				output.matrix[i][j] = input.matrix[input.size[0]-i-1][input.size[1]-j-1]; 
			}
		}
		return output; 
	}
	
	
	private static PoolingResult maxPooling(Mat input) {
		
		Mat output = new Mat(input.size[0] / 2, input.size[1] / 2); 
		Mat mask = new Mat(input.size[0], input.size[1], 0); 
		for (int i = 0; i < input.size[0] ; i = i + 2) {
			for (int j = 0; j < input.size[1]; j = j + 2) {
				Mat temp = new Mat(2,2); 
				temp.matrix[0][0] = input.matrix[i][j];
				temp.matrix[0][1] = input.matrix[i][j+1];
				temp.matrix[1][0] = input.matrix[i+1][j];
				temp.matrix[1][1] = input.matrix[i+1][j+1];
				Result max = Mat.max(temp); 
				output.matrix[i/2][j/2] = max.max; 
				mask.matrix[i+max.idx[0]][j+max.idx[1]] = 1; 
			}
		}
		
		return new PoolingResult(output, mask); 
	}
	
	private static Mat upsample(Mat input, Mat mask) {
		Mat output = new Mat(mask.size[0], mask.size[1], 0); 
		
		for (int i = 0; i < input.size[0]; i++) {
			for (int j = 0; j < input.size[1]; j++) {
				
				int aMin = i*2, aMax = i*2+1, bMin = j*2, bMax = j*2+1; 
				if (aMax >= output.size[0]) {
					aMax = output.size[0] - 1; 
				}
				if (bMax >= output.size[1]) {
					bMax = output.size[1] - 1; 
				}
				
				Result max = Mat.max(mask.range(aMin, aMax, bMin, bMax)); 
				output.matrix[aMin + max.idx[0]][bMin + max.idx[1]] = input.matrix[i][j]; 
			}
		}
		return output; 
	}

}
