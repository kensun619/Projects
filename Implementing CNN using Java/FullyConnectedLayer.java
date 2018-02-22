/**
 * Finalized File
 * DO NOT CHANGE THIS FILE
 * Author: Zhanpeng Zeng
 */


public class FullyConnectedLayer implements ANNLayer{

	private Mat inputWeight; 
	private boolean set = false; 
	private int fout; 
	
	private Mat lastInputBiased = null; 
	
	public FullyConnectedLayer(int fout) {
		this.fout = fout; 
	}
	
	public FullyConnectedLayer() {
		
	}
	
	@Override
	public DataContainer forwardProp(DataContainer forwardPropData, boolean training) {
		// TODO Auto-generated method stub
		Mat input = forwardPropData.getVec(); 
		
		if (!set) {
			inputWeight = Mat.randomMatrix(input.size[1] + 1, fout, - 0.3, 0.3); 
			set = true; 
		}
		
		Mat inputBiased = (input).appendRight(new Mat(1,1,1)); 
		Mat output = inputBiased.mul(inputWeight); 
		if (training) {
			lastInputBiased = inputBiased; 
		}
		else {
			lastInputBiased = null; 
		}
		
		return new DataContainer(output); 
	}
	
	@Override
	public DataContainer backProp(DataContainer backPropError, double learningRate) {
		// TODO Auto-generated method stub
		if (lastInputBiased == null) {
			throw new RuntimeException("Invalid operation"); 
		}
		Mat error = backPropError.getVec(); 
		
		Mat dW = lastInputBiased.T().mul(error).scale(learningRate); 
		
		Mat temp = error.mul(inputWeight.T()); 
        Mat output = new Mat(temp.size[0], temp.size[1] - 1); 
        for (int i = 0; i < output.size[1]; i++) {
        	output.matrix[0][i] = temp.matrix[0][i]; 
        }
        
		inputWeight = inputWeight.add(dW); 
		
		return new DataContainer(output); 
	}

	@Override
	public ANNLayer copy() {
		// TODO Auto-generated method stub
		FullyConnectedLayer output = new FullyConnectedLayer(); 
		output.inputWeight = this.inputWeight.copy(); 
		output.fout = this.fout; 
		output.set = this.set; 
		return output; 
	}
	
	

}
