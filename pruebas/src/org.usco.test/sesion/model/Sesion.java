package org.usco.uscoia.Sesion;

public class Sesion {
    private int id;
	private int usuario;
	private TimeStamp fecha_hora_start;
	private TimeStamp fecha_hora_end;
	private String ip;

	
	public Sesion() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Sesion(int id, int usuario, TimeStamp fecha_hora_start, TimeStamp fecha_hora_end, String ip) {
		super();
		this.id = id;
		this.usuario = usuario;
		this.fecha_hora_start = fecha_hora_start;
		this.fecha_hora_end = fecha_hora_end;
		this.ip = ip;

	}

	public Sesion(int usuario, TimeStamp fecha_hora_start, TimeStamp fecha_hora_end, String ip) {
		super();
		this.usuario = usuario;
		this.fecha_hora_start = fecha_hora_start;
		this.fecha_hora_end = fecha_hora_end;
		this.ip = ip;

	}
    
    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	public int getUsuario() {
		return usuario;
	}

	public void setUsuario(int usuario) {
		this.usuario = usuario;
	}
	public TimeStamp getFecha_hora_start() {
		return fecha_hora_start;
	}

	public void setFecha_hora_start(TimeStamp fecha_hora_start) {
		this.fecha_hora_start = fecha_hora_start;
	}
	public TimeStamp getFecha_hora_end() {
		return fecha_hora_end;
	}

	public void setFecha_hora_end(TimeStamp fecha_hora_end) {
		this.fecha_hora_end = fecha_hora_end;
	}
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

    
    
	
	
	
	@Override
	public String toString() {
		return "Sesion [id=" + id + ", pais=" + pais + ", nombre=" + nombre + ", acronimo=" + acronimo + "]";
	}
	

}
