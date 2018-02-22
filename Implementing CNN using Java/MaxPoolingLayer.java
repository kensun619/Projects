import java.util.ArrayList;
import java.util.List;

public class MaxPoolingLayer implements ANNLayer{
	private boolean set = false; 
	private Mat[] poolingMask; 
	
	public MaxPoolingLayer() {
		
	}
	
	@Override
	public DataContainer forwardProp(DataContainer forwardPropData, boolean training) {
		// TODO Auto-generated method stub

		List<Mat> input = forwardPropData.getImgs(); 
		if (!set) {
			poolingMask = new Mat[input.size()]; 
			set = true; 
		}
		
		List<Mat> output = new ArrayList<Mat>(); 
		for (int i = 0; i < input.size(); i++) {
			PoolingResult result = maxPooling(input.get(i)); 
			output.add(result.output); 
			poolingMask[i] = result.mask; 
		}
		
		return new DataContainer(output); 
	}

	@Override
	public DataContainer backProp(DataContainer backPropError, double learningRate) {
		// TODO Auto-generated method stub

		List<Mat> input = backPropError.getImgs(); 
		
		List<Mat> output = new ArrayList<Mat>(); 
		for (int i = 0; i < input.size(); i++) {
			output.add(upsample(input.get(i), i)); 
		}
		return new DataContainer(output); 
	}
	
	private PoolingResult maxPooling(Mat input) {
		Mat minput; 
		if (input.size[0] % 2 == 0 && input.size[1] % 2 == 0) {
			minput = input; 
		} else {
			minput = new Mat (input.size[0] + (input.size[0] % 2), input.size[1] + (input.size[1] % 2), - Double.MAX_VALUE); 
			for (int i = 0; i < input.size[0]; i++) {
				for (int j = 0; j < input.size[1]; j++) {
					minput.matrix[i][j] = input.matrix[i][j]; 
				}
			}
		}
		
		Mat output = new Mat(minput.size[0] / 2, minput.size[1] / 2); 
		Mat mask = new Mat(input.size[0], input.size[1], 0); 
		for (int i = 0; i < minput.size[0] ; i = i + 2) {
			for (int j = 0; j < minput.size[1]; j = j + 2) {
				Mat temp = new Mat(2,2); 
				temp.matrix[0][0] = minput.matrix[i][j];
				temp.matrix[0][1] = minput.matrix[i][j+1];
				temp.matrix[1][0] = minput.matrix[i+1][j];
				temp.matrix[1][1] = minput.matrix[i+1][j+1];
				Result max = Mat.max(temp); 
				output.matrix[i/2][j/2] = max.max; 
				mask.matrix[i+max.idx[0]][j+max.idx[1]] = 1; 
			}
		}
		
		return new PoolingResult(output, mask); 
	}
	
	private Mat upsample(Mat input, int maskIdx) {
		Mat output = new Mat(poolingMask[maskIdx].size[0], poolingMask[maskIdx].size[1], 0); 
		
		for (int i = 0; i < output.size[0]; i++) {
			for (int j = 0; j < output.size[1]; j++) {
				if (poolingMask[maskIdx].matrix[i][j] == 1) {
					output.matrix[i][j] = input.matrix[i/2][j/2];
				}
			}
		}
		
		return output; 
	}
	
	@Override
	public ANNLayer copy() {
		// TODO Auto-generated method stub
		return this; 
	}

}

class PoolingResult {
	public Mat output; 
	public Mat mask; 
	public PoolingResult(Mat output, Mat mask) {
		this.output = output; 
		this.mask = mask; 
	}
}