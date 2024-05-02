package org.usco.uscoia.Role;

public class Role {
    private int id;
	private String name;
	private int state;

	
	public Role() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Role(int id, String name, int state) {
		super();
		this.id = id;
		this.name = name;
		this.state = state;

	}

	public Role(String name, int state) {
		super();
		this.name = name;
		this.state = state;

	}
    
    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

    
    
	
	
	
	@Override
	public String toString() {
		return "Role [id=" + id + ", pais=" + pais + ", nombre=" + nombre + ", acronimo=" + acronimo + "]";
	}
	

}
