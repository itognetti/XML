<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="usuario" />

    <xsl:template match="biblioteca">
        <html>
            <head>
                <title>Prestamos de <xsl:value-of select="//usuario[@id=$usuario]/datos_personales/nombre"/></title>
            </head>
            <body>
                <xsl:apply-templates/>
                <xsl:call-template name="usuario">
                    <xsl:with-param name="user" select="//usuario[@id=$usuario]" />
                </xsl:call-template>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="libros"/>
    <xsl:template match="usuarios"/>

    <xsl:template name="usuario">
        <xsl:param name="user" />
        <h1>Prestamos de <xsl:value-of select="$user/datos_personales/nombre"/></h1>
        <xsl:call-template name="obtener_prestamos">
            <xsl:with-param name="prestamos" select="$user/prestamos" />
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="obtener_prestamos">
        <xsl:param name="prestamos" />
        <table border="1">
            <tr>
                <th>Libro</th>
                <th>Fecha de prestamo</th>
                <th>Fecha de devolucion</th>
            </tr>
            <tbody>
                <xsl:for-each select="$prestamos/prestamo">
                    <xsl:call-template name="imprimir_prestamo">
                        <xsl:with-param name="prestamo" select="." />
                    </xsl:call-template>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template name="imprimir_prestamo">
        <xsl:param name="prestamo" />
        <tr>
            <td>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="$prestamo/libro_prestado/@id"/>.html
                    </xsl:attribute>
                    <xsl:value-of select="//libros/libro[@id=$prestamo/libro_prestado/@id]/titulo" />
                </xsl:element>
            </td>
            <td><xsl:value-of select="$prestamo/fecha_perstamo"/></td>
            <td><xsl:value-of select="$prestamo/fecha_devolucion"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>