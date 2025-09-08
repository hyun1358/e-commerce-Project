package vo;

public class LaptopSpecVO 
{
	/* 
	 SPEC_ID    - idx
	 PRODUCT_ID - fk
	 CPU - cpu
	 RAM -  GB
	 STORAGE_TYPE - 저장장치 종류 
	 STORAGE_SIZE - 저장장치 용량
	 GPU - 그래픽카드
	 AUDIO_DESCRIPTION - 오디오
	 NETWORK - 네트워크
	 PORTS - 포트
	 SCREEN_SIZE - 화면크기(인치)
	 WEIGHT - 무게
	 RESOLUTION - 해상도
	 RELEASE_DATE - 출시일
	 BLUETOOTH -  블루투스 버전
	 *  
	 */
	
	private int spec_id, product_id, ram, storage_size;
	private String cpu, storage_type,storage_unit , gpu, audio_description, network, ports, resolution, release_date, formatter_date,bluetooth, dimensions;
	private double screen_size, weight;
	
	public String getFormatter_date() {
		return formatter_date;
	}
	public void setFormatter_date(String formatter_date) {
		this.formatter_date = formatter_date;
	}
	public void setScreen_size(double screen_size) {
		this.screen_size = screen_size;
	}
	

	public String getDimensions() {
		return dimensions;
	}
	public void setDimensions(String dimensions) {
		this.dimensions = dimensions;
	}
	public String getStorage_unit() {
		return storage_unit;
	}
	public void setStorage_unit(String storage_unit) {
		this.storage_unit = storage_unit;
	}
	public int getSpec_id() {
		return spec_id;
	}
	public void setSpec_id(int spec_id) {
		this.spec_id = spec_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getRam() {
		return ram;
	}
	public void setRam(int ram) {
		this.ram = ram;
	}
	public int getStorage_size() {
		return storage_size;
	}
	public void setStorage_size(int storage_size) {
		this.storage_size = storage_size;
	}
	public double getScreen_size() {
		return screen_size;
	}
	public void setScreen_size(int screen_size) {
		this.screen_size = screen_size;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public String getCpu() {
		return cpu;
	}
	public void setCpu(String cpu) {
		this.cpu = cpu;
	}
	public String getStorage_type() {
		return storage_type;
	}
	public void setStorage_type(String storage_type) {
		this.storage_type = storage_type;
	}
	public String getGpu() {
		return gpu;
	}
	public void setGpu(String gpu) {
		this.gpu = gpu;
	}
	public String getAudio_description() {
		return audio_description;
	}
	public void setAudio_description(String audio_description) {
		this.audio_description = audio_description;
	}
	public String getNetwork() {
		return network;
	}
	public void setNetwork(String network) {
		this.network = network;
	}
	public String getPorts() {
		return ports;
	}
	public void setPorts(String ports) {
		this.ports = ports;
	}
	public String getResolution() {
		return resolution;
	}
	public void setResolution(String resolution) {
		this.resolution = resolution;
	}
	public String getRelease_date() {
		return release_date;
	}
	public void setRelease_date(String release_date) {
		this.release_date = release_date;
	}
	public String getBluetooth() {
		return bluetooth;
	}
	public void setBluetooth(String bluetooth) {
		this.bluetooth = bluetooth;
	}
}
