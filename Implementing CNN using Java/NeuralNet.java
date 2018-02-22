/**
 * Finalized File
 * DO NOT CHANGE THIS FILE
 * Author: Zhanpeng Zeng
 */

import java.util.ArrayList;
import java.util.List;

public class NeuralNet {
	private List<ANNLayer> currNetwork; 
	
	private Data trainingData, tuningData; 
	
	public double trainLoss; 
	public double trainError, tuneError; 
	
	private double bestTuneError; 
	private List<ANNLayer> earlyStopNetwork; 
	
	private boolean networkStructureFinalized = false; 
	
	public NeuralNet(Data trainingData, Data tuningData) {
		currNetwork = new ArrayList<ANNLayer>(); 
		this.trainingData = trainingData; 
		this.tuningData = tuningData; 
	}
	
	public void train(double learningRate, boolean suffleTrainingSet) {
		if (!networkStructureFinalized) {
			throw new RuntimeException("Network Configuration not finalized"); 
		}
		if (suffleTrainingSet) {
			trainingData.shuffle();
		}
		
		for (int idx = 0; idx < this.trainingData.size(); idx++) {
			DataContainer inst = trainingData.get(idx); 
			DataContainer forwardPropData = inst; 
			for (int layer = 0; layer < this.currNetwork.size(); layer++) {
				ANNLayer currLayer = currNetwork.get(layer); 
				forwardPropData = currLayer.forwardProp(forwardPropData, true); 
			}
			
			//---------------------------------------
			Mat output = forwardPropData.getVec(); 
			Mat y = inst.getLabel(); 
			DataContainer backPropError = new DataContainer(y.add(output.scale(-1))); 
			//---------------------------------------
			
			for (int layer = this.currNetwork.size() - 1; layer >= 0; layer--) {
				ANNLayer currLayer = currNetwork.get(layer); 
				backPropError = currLayer.backProp(backPropError, learningRate); 
			}
		}
		
		error(); 
		if (tuneError < bestTuneError) {
			bestTuneError = tuneError; 
			copyCurrNetworkAsEarlyStopNetwork(); 
		}
	}
	
	
	private void error() {
		trainLoss = 0; 
		trainError = 0; 
		tuneError = 0; 

		for (int idx = 0; idx < this.trainingData.size(); idx++) {
			DataContainer inst = trainingData.get(idx); 
			DataContainer forwardPropData = inst; 
			for (int layer = 0; layer < this.currNetwork.size(); layer++) {
				ANNLayer currLayer = currNetwork.get(layer); 
				forwardPropData = currLayer.forwardProp(forwardPropData, false); 
			}
			
			Mat output = forwardPropData.getVec(); 
			Result maxOutput = Mat.max(output); 
			Result actual = Mat.max(inst.getLabel()); 
			if (actual.idx[1] != maxOutput.idx[1]) {
				trainError++; 
			}
			
			Mat y = inst.getLabel(); 
			trainLoss = trainLoss + 0.5 * Mat.sum(Mat.pow(y.add(output.scale(-1)), 2)); 
		}
		trainError = trainError / trainingData.size(); 
		
		for (int idx = 0; idx < this.tuningData.size(); idx++) {
			DataContainer inst = tuningData.get(idx); 
			DataContainer forwardPropData = inst; 
			for (int layer = 0; layer < this.currNetwork.size(); layer++) {
				ANNLayer currLayer = currNetwork.get(layer); 
				forwardPropData = currLayer.forwardProp(forwardPropData, false); 
			}
			
			Mat output = forwardPropData.getVec(); 
			Result maxOutput = Mat.max(output); 
			Result actual = Mat.max(inst.getLabel()); 
			if (actual.idx[1] != maxOutput.idx[1]) {
				tuneError++; 
			}
		}
		tuneError = tuneError / tuningData.size(); 
		
	}
	
	public Mat predict(DataContainer inst) {
		DataContainer forwardPropData = inst; 
		for (int layer = 0; layer < this.currNetwork.size(); layer++) {
			ANNLayer currLayer = currNetwork.get(layer); 
			forwardPropData = currLayer.forwardProp(forwardPropData, false); 
		}
		
		return forwardPropData.getVec(); 
	}
	
	public NeuralNet getEarlyStopModel() {
		NeuralNet model = new NeuralNet(trainingData, tuningData); 
		model.currNetwork = this.earlyStopNetwork; 
		return model; 
	}
	
	private void copyCurrNetworkAsEarlyStopNetwork() {
		earlyStopNetwork = new ArrayList<ANNLayer>(); 
		for (int i = 0; i < this.currNetwork.size(); i++) {
			earlyStopNetwork.add(currNetwork.get(i).copy()); 
		}
	}
	
	public void finalizeConfiguration() {
		networkStructureFinalized = true; 
		
		error(); 
		
		bestTuneError = tuneError; 
		copyCurrNetworkAsEarlyStopNetwork(); 
	}
	
	public void stuckConvolutionLayer(int filerSize, int numOutPla) {
		currNetwork.add(new ConvolutionLayer(filerSize, numOutPla)); 
	}
	
	public void stuckMaxPoolingLayer() {
		currNetwork.add(new MaxPoolingLayer()); 
	}
	
	public void stuckVectorizationLayer() {
		currNetwork.add(new VectorizationLayer()); 
	}
	
	public void stuckFullyConnectedLayer(int fout) {
		currNetwork.add(new FullyConnectedLayer(fout)); 
	}
	
	public void stuckReLUActivationLayer(double dropOutRate) {
		currNetwork.add(new ReLUActivationLayer(dropOutRate)); 
	}
	
	public void stuckLinearActivationLayer(double dropOutRate) {
		currNetwork.add(new LinearActivationLayer(dropOutRate)); 
	}
	
	public void stuckSigmoidActivationLayer(double dropOutRate) {
		currNetwork.add(new SigmoidActivationLayer(dropOutRate)); 
	}
}
