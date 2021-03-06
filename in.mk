NAME=		avlbst
PREFIX=		/usr/local
INCDIR=		$(PREFIX)/include
LIBDIR=		$(PREFIX)/lib
MANDIR=		$(PREFIX)/share/man

LIB=		lib$(NAME).so
LIBV=		$(LIB).2
LIBVV=		$(LIBV).1.2

OBJS=		bst.o

MANS=		avl_add avl_add_at avl_del avl_del_node bst_srch bst_add \
		bst_add_at bst_del bst_del_node

_CFLAGS=	$(CFLAGS) $(__CDBG) $(__CLDBG)
_LDFLAGS=	$(LDFLAGS) $(__CLDBG) \
		-s

$(LIBVV):	$(OBJS)
		$(CC) $(_LDFLAGS) -shared -Wl,-soname,${LIBV} \
		    -o $@ $(OBJS)
		rm -f ${LIB} ${LIBV}
		ln -s ${LIBVV} ${LIBV}
		ln -s ${LIBV} ${LIB}

install: $(INCDIR) $(LIBDIR) $(MANDIR)/man3
		install -m 644 bst.h $(INCDIR)/$(NAME).h
		install ${LIBVV} ${LIBDIR}/
		cd ${LIBDIR}; \
		rm -f ${LIB} ${LIBV}; \
		ln -s ${LIBVV} ${LIBV}; \
		ln -s ${LIBV} ${LIB}
		sed 's"ds LIBDIR .*$$"ds LIBDIR $(LIBDIR)"' bst.3 \
		    > $(MANDIR)/man3/lib$(NAME).3
		cd $(MANDIR)/man3; \
		for i in $(MANS); do \
			[ -e $$i.3 ] || ln -s lib$(NAME).3 $$i.3; \
		done

uninstall:
		rm -f $(INCDIR)/$(NAME).h
		for i in $(LIB) $(LIBV) $(LIBVV); do \
			rm -f $(LIBDIR)/$$i; \
		done
		rm -f $(MANDIR)/man3/lib$(NAME).3
		for i in $(MANS); do \
			if [ -h $(MANDIR)/man3/$$i ]; then \
				rm -f $(MANDIR)/man3/$$i; \
			fi; \
		done

clean:
		rm -f $(OBJS) $(LIB)*

distclean:	clean
		rm -f Makefile config.log

$(INCDIR) $(LIBDIR) $(MANDIR)/man3:
	[ -d $@ ] || mkdir -p $@

.c.o:
		${CC} -fPIC $(_CFLAGS) ${CPPFLAGS} -c $<

bst.o:		bst.h
