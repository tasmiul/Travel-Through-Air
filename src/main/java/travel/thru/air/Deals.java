package travel.thru.air;

public class Deals {
	String departure;
	String arrival;
	int expiry;
	int discounted_price;

	public Deals( String departure, String arrival, int expiry, int discounted_price){
		this.departure = departure;
	    this.arrival = arrival;
	    this.expiry = expiry;
	    this.discounted_price = discounted_price;
	}

	public String getDeparture(){
		return departure;
	}
	
	public String getArrival(){
		return arrival;
	}

	public int getExpiry(){
		return this.expiry;
	}
	
	public String getDealTime() {
		String x = String.format("%04d",getExpiry());
		x = x.substring(0, 2) + ":" + x.substring(2, x.length());
		return x;
	}

	public int getPrice(){
		return this.discounted_price;
	}
	
}
