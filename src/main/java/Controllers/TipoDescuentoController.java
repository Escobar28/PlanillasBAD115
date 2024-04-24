/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import Models.TipoDescuento;
import java.util.List;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class TipoDescuentoController {

    public boolean create(String nombretipodesc, String habilitado) {

        //Se genera un objeto SessionFactory para cargar la configuracion hibernate.cfg.xml
        SessionFactory sessionFactory = new Configuration().configure().addAnnotatedClass(TipoDescuento.class).buildSessionFactory();
        //Se abre la sesion con la base de datos (en cualquier operacion CRUD)
        Session session = sessionFactory.openSession();

        try {
            TipoDescuento tipodescuento = new TipoDescuento();
            tipodescuento.setNombretipodesc(nombretipodesc);
            tipodescuento.setHabilitado(habilitado);

            System.out.print(tipodescuento.toString());

            session.beginTransaction();
            session.save(tipodescuento);
            session.getTransaction().commit();
            sessionFactory.close();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<TipoDescuento> mostrarTipoDescuento() {

        //Se genera un objeto SessionFactory para cargar la configuracion hibernate.cfg.xml
        SessionFactory sessionFactory = new Configuration().configure().addAnnotatedClass(TipoDescuento.class).buildSessionFactory();
        //Se abre la sesion con la base de datos (en cualquier operacion CRUD)
        Session session = sessionFactory.openSession();
        List<TipoDescuento> tiposdescuentos = null;

        try {
            session.beginTransaction();
            Query<TipoDescuento> query = session.createQuery("FROM TipoDescuento WHERE habilitado='1'", TipoDescuento.class);
            tiposdescuentos = query.getResultList();
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sessionFactory.close();

        }
        return tiposdescuentos;
    }

    public TipoDescuento search(int id) {

        //Se genera un objeto SessionFactory para cargar la configuracion hibernate.cfg.xml
        SessionFactory sessionFactory = new Configuration().configure().addAnnotatedClass(TipoDescuento.class).buildSessionFactory();
        //Se abre la sesion con la base de datos (en cualquier operacion CRUD)
        Session session = sessionFactory.openSession();
        TipoDescuento tipodescuento = null;
        //Intenta lo siguiente...
        try {
            //Inicia una transaccion el objeto session
            session.beginTransaction();
            //Elimina el registro con el parametro id
            tipodescuento = session.get(TipoDescuento.class, id);
            //Obtiene la transaccion en memoria y guarda los valores en la base de datos
            session.getTransaction().commit();
            //Se cierra la conexion a la base de datos
            sessionFactory.close();

        } catch (Exception e) {
            //En caso de error imprime la pila de errores
            e.printStackTrace();
        }

        return tipodescuento;
    }

    public void update(TipoDescuento tipodescuento) {

        //Se genera un objeto SessionFactory para cargar la configuracion hibernate.cfg.xml
        SessionFactory sessionFactory = new Configuration().configure().addAnnotatedClass(TipoDescuento.class).buildSessionFactory();
        //Se abre la sesion con la base de datos (en cualquier operacion CRUD)
        Session session = sessionFactory.openSession();

        try {

            session.beginTransaction();
            session.update(tipodescuento);
            session.getTransaction().commit();
            sessionFactory.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(TipoDescuento tipodescuento) {

        //Se genera un objeto SessionFactory para cargar la configuracion hibernate.cfg.xml
        SessionFactory sessionFactory = new Configuration().configure().addAnnotatedClass(TipoDescuento.class).buildSessionFactory();
        //Se abre la sesion con la base de datos (en cualquier operacion CRUD)
        Session session = sessionFactory.openSession();

        try {

            session.beginTransaction();
            session.update(tipodescuento);
            session.getTransaction().commit();
            sessionFactory.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}