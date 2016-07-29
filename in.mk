INCDIR=		/usr/local/include
LIBDIR=		/usr/local/lib
MANDIR=		/usr/local/share/man
NAME=		avlbst

LIB=		lib$(NAME).so
LIBV=		$(LIB).1
LIBVV=		$(LIBV).0.1

OBJS=		bst.o

DBG=		#-g -O0 -fno-omit-frame-pointer -fno-optimize-sibling-calls \
		-fsanitize=undefined \
		-fsanitize=integer \
		#-fsanitize=address
_CFLAGS=	$(CFLAGS) $(DBG) -Wall -Wextra
_LDFLAGS=	$(LDFLAGS) $(DBG) -s

$(LIBVV):	$(OBJS)
		$(CC) $(_LDFLAGS) -shared -Wl,-soname,${LIBV} \
		    -o $@ $(OBJS)
		rm -f ${LIB} ${LIBV}
		ln -s ${LIBVV} ${LIBV}
		ln -s ${LIBV} ${LIB}

install:
		[ -e $(INCDIR) ] || mkdir -p $(INCDIR)
		install -m 644 bst.h $(INCDIR)/$(NAME).h
		[ -e ${LIBDIR} ] || mkdir -p ${LIBDIR}
		install ${LIBVV} ${LIBDIR}/
		cd ${LIBDIR}; \
		rm -f ${LIB} ${LIBV}; \
		ln -s ${LIBVV} ${LIBV}; \
		ln -s ${LIBV} ${LIB}
		[ -e $(MANDIR)/man3 ] || mkdir -p $(MANDIR)/man3
		sed 's"ds LIBDIR .*$$"ds LIBDIR $(LIBDIR)"' bst.3 \
		    > $(MANDIR)/man3/lib$(NAME).3
		cd $(MANDIR)/man3; \
		for i in avl_add avl_del avl_del_node bst_srch bst_add \
		    bst_del bst_del_node; do \
			[ -e $$i.3 ] || ln -s lib$(NAME).3 $$i.3; \
		done

uninstall:
		rm -f $(INCDIR)/$(NAME).h
		for i in $(LIB) $(LIBV) $(LIBVV); do \
			rm -f $(LIBDIR)/$$i; \
		done
		rm -f $(MANDIR)/man3/lib$(NAME).3
		for i in avl_add avl_del avl_del_node bst_srch bst_add \
		    bst_del bst_del_node; do \
			if [ -h $(MANDIR)/man3/$$i ]; then \
				rm -f $(MANDIR)/man3/$$i; \
			fi; \
		done

clean:
		rm -f $(OBJS) $(LIB)*

.c.o:
		${CC} -fPIC $(_CFLAGS) ${CPPFLAGS} -c $<

bst.o:		bst.h
