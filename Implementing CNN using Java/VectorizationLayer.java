/**
 * Finalized File
 * DO NOT CHANGE THIS FILE
 * Author: Zhanpeng Zeng
 */

import java.util.ArrayList;
import java.util.List;

public class VectorizationLayer implements ANNLayer {
	private boolean set = false; 
	private int height, width; 
	private int numImgs; 
	
	public VectorizationLayer() {
		
	}
	
	@Override
	public DataContainer forwardProp(DataContainer forwardPropData, boolean training) {
		// TODO Auto-generated method stub
		
		List<Mat> input = forwardPropData.getImgs(); 
		
		if (input.size() == 0) {
			throw new IllegalArgumentException("Passing empty input data"); 
		}
		
		if (!set) {
			Mat matrix = input.get(0); 
			height = matrix.size[0]; 
			width = matrix.size[1]; 
			numImgs = input.size(); 
			set = true; 
		}
		
		Mat output = new Mat(1, height * width * numImgs, 0); 
		int idx = 0; 
		for (int i = 0; i < input.size(); i++) {
			Mat inMatrix = input.get(i); 
			for (int a = 0; a < inMatrix.size[0]; a++) {
				for (int b = 0; b < inMatrix.size[1]; b++) {
					output.matrix[0][idx] = inMatrix.matrix[a][b]; 
					idx++; 
				}
			}
		}
		
		return new DataContainer(output); 
	}

	@Override
	public DataContainer backProp(DataContainer backPropError, double learningRate) {
		// TODO Auto-generated method stub
		
		Mat vector = backPropError.getVec(); 
		if(vector.size[0] != 1 || vector.size[1] != height * width * numImgs) {
			throw new IllegalArgumentException("Vector length mismatch"); 
		}
		//System.out.println(vector);
		List<Mat> output = new ArrayList<Mat>(); 
		int idx = 0; 
		for (int i = 0; i < numImgs; i++) {
			Mat img = new Mat(height, width, 0); 
			for (int a = 0; a < height; a++) {
				for (int b = 0; b < width; b++) {
					img.matrix[a][b] = vector.matrix[0][idx]; 
					idx++; 
				}
			}
			output.add(img); 
		}
		
		return new DataContainer(output); 
	}

	@Override
	public ANNLayer copy() {
		// TODO Auto-generated method stub
		return this; 
	}
	
	
}
