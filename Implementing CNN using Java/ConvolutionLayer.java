import java.util.ArrayList;
import java.util.List;

public class ConvolutionLayer implements ANNLayer {
	private Mat[][] filters; 
	private Mat[] lastInput; 
	private int numOutPla, filterSize; 
	private boolean set = false; 
	
	public ConvolutionLayer(int filterSize, int numOutPla) {
		this.numOutPla = numOutPla; 
		this.filterSize = filterSize; 
	}
	
	@Override
	public DataContainer forwardProp(DataContainer forwardPropData, boolean training) {
		// TODO Auto-generated method stub
		List<Mat> input = forwardPropData.getImgs(); 
		
		if (!set) {
			filters = new Mat[this.numOutPla][input.size() + 1]; 
			for (int i = 0; i < filters.length; i++) {
				for (int j = 0; j <filters[0].length; j++) {
					filters[i][j] = Mat.randomMatrix(filterSize, filterSize, - 0.3, 0.3); 
				}
			}
			lastInput = new Mat[input.size() + 1]; 
			lastInput[input.size()] = new Mat(input.get(0).size[0], input.get(0).size[1], 1); 
			set = true; 
		}
		
		for (int i = 0; i < input.size(); i++) {
			lastInput[i] = input.get(i);  
		}
		
		List<Mat> output = new ArrayList<Mat>(); 
		for (int i = 0; i < filters.length; i++) {
			Mat out = Conv.Conv2Valid(lastInput[0], filters[i][0]); 
			for (int j = 1; j < filters[i].length; j++) {
				out = out.add(Conv.Conv2Valid(lastInput[j], filters[i][j])); 
			}
			output.add(out); 
		}
		
		return new DataContainer(output); 
	}



	@Override
	public DataContainer backProp(DataContainer backPropError, double learningRate) {
		// TODO Auto-generated method stub
		List<Mat> errorList = backPropError.getImgs(); 
		
		List<Mat> outputList = new ArrayList<Mat>(); 
		for (int i = 0; i < lastInput.length-1; i++) {
			Mat error = Conv.Conv2Full(errorList.get(0), ROT180(filters[0][i])); 
			for (int j = 1; j < filters.length; j++) {
				error = error.add(Conv.Conv2Full(errorList.get(j), ROT180(filters[j][i]))); 
			}
			outputList.add(error); 
		}
		
		Mat lInputROT180[] = new Mat[lastInput.length]; 
		for (int i = 0; i < lastInput.length; i++) {
			lInputROT180[i] = ROT180(lastInput[i]); 
		}
		
		for (int i = 0; i < errorList.size(); i++) {
			Mat error = errorList.get(i); 
			for (int j = 0; j < lastInput.length; j++) {
				Mat dW = Conv.Conv2Valid(lastInput[j], ROT180(error)); 
				filters[i][j] = filters[i][j].add(dW.scale(- learningRate)); 
			}
		}
		//System.out.println(filters[0][0]);
		return new DataContainer(outputList); 
	}

	@Override
	public ANNLayer copy() {
		// TODO Auto-generated method stub
		ConvolutionLayer layer = new ConvolutionLayer(filterSize, numOutPla); 
		layer.filters = new Mat[this.filters.length][this.filters[0].length]; 
		for (int i = 0; i < layer.filters.length; i++) {
			for (int j = 0; j < layer.filters[i].length; j++) {
				layer.filters[i][j] = this.filters[i][j].copy(); 
			}
		}
		layer.set = this.set; 
		
		return layer; 
	}
	
	private Mat ROT180(Mat input) {
		Mat output = new Mat(input.size[0], input.size[1], 0); 
		for (int i = 0; i < input.size[0]; i++) {
			for (int j = 0; j < input.size[1]; j++) {
				output.matrix[i][j] = input.matrix[input.size[0]-i-1][input.size[1]-j-1]; 
			}
		}
		return output; 
	}
}

/**
 * Finalized Class
 * DO NOT CHANGE THIS CLASS
 * Author: Zhanpeng Zeng
 */
class Conv {
	public static Mat Conv2Full(Mat input, Mat kernel) {
		int inputH = input.size[0]; 
		int inputW = input.size[1]; 
		int kernH = kernel.size[0]; 
		int kernW = kernel.size[1]; 
		
		Mat output = new Mat(inputH + kernH - 1, inputW + kernW - 1, 0); 
		
		for (int i = 0; i < inputH; i++) {
			for (int j = 0; j < inputW; j++) {
				Mat temp = kernel.scale(input.matrix[i][j]); 
				for (int m = 0; m < kernH; m++) {
					for (int n = 0; n < kernW; n++) {
						output.matrix[i+m][j+n] += temp.matrix[m][n]; 
					}
				}
			}
		}
		return output; 
	}
	
	public static Mat Conv2Valid(Mat input, Mat kernel) {
		int inputH = input.size[0]; 
		int inputW = input.size[1]; 
		int kernH = kernel.size[0]; 
		int kernW = kernel.size[1]; 
		if (inputH - kernH + 1 <= 0 || inputW - kernW + 1 <= 0) {
			throw new RuntimeException("invalid input size"); 
		}
		
		Mat fullOutput = Conv2Full(input, kernel); 
		
		Mat output = new Mat(inputH - kernH + 1, inputW - kernW + 1); 
		for (int i = 0; i < output.size[0]; i++) {
			for (int j = 0; j < output.size[1]; j++) {
				output.matrix[i][j] = fullOutput.matrix[i + kernH - 1][j + kernW - 1]; 
			}
		}
		return output; 
	}
	
	public static Mat Conv2Same(Mat input, Mat kernel) {
		int inputH = input.size[0]; 
		int inputW = input.size[1]; 
		int kernH = kernel.size[0]; 
		int kernW = kernel.size[1]; 
		if (inputH - kernH + 1 <= 0 || inputW - kernW + 1 <= 0) {
			throw new RuntimeException("invalid input size"); 
		}
		
		Mat fullOutput = Conv2Full(input, kernel); 
		
		Mat output = new Mat(inputH, inputW); 
		for (int i = 0; i < output.size[0]; i++) {
			for (int j = 0; j < output.size[1]; j++) {
				output.matrix[i][j] = fullOutput.matrix[i + (kernH - 1)/2][j + (kernW - 1)/2]; 
			}
		}
		return output; 
	}
}



